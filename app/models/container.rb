#==============================================================================
# Copyright (C) 2019-present Alces Flight Ltd.
#
# This file is part of flight-cache-server.
#
# This program and the accompanying materials are made available under
# the terms of the Eclipse Public License 2.0 which is available at
# <https://www.eclipse.org/legal/epl-2.0>, or alternative license
# terms made available by Alces Flight Ltd - please direct inquiries
# about licensing to licensing@alces-flight.com.
#
# This project is distributed in the hope that it will be useful, but
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR
# IMPLIED INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OR CONDITIONS
# OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A
# PARTICULAR PURPOSE. See the Eclipse Public License 2.0 for more
# details.
#
# You should have received a copy of the Eclipse Public License 2.0
# along with this project. If not, see:
#
#  https://opensource.org/licenses/EPL-2.0
#
# For more information on flight-account, please visit:
# https://github.com/alces-software/flight-cache-server
#===============================================================================

require 'aws-sdk-s3'
require 'errors'
require 'scope_parser'

class Container < ApplicationRecord
  # validates presence user XOR group
  [owners = [:user, :group], owners.reverse].each do |owner1, owner2|
    belongs_to owner1, optional: true
    validates owner1, absence: true, if: owner2
    validates owner1, presence: true, unless: owner2
  end

  delegate :max_size, :restricted, :restricted?, to: :tag

  has_many :blobs
  belongs_to :tag

  # Dummy method for use in the serialization. This way the container can
  # be determined for the model without checking its type first
  def container
    self
  end

  def scope
    ScopeParser.find_container_scope(self)
  end

  def readable?(other)
    access?(:readable?, other)
  end

  def writable?(other)
    return false if tag.restricted?
    access?(:writable?, other)
  end

  def owner
    user || group
  end

  def raise_if_exceeds_max_size(io)
    return if io.size < max_size
    raise UploadTooLarge, <<~ERROR.squish
      Can not upload the file as the maximum size is #{max_size}B, but the file
      is #{io.size}B
    ERROR
  end

  private

  def access?(method, other)
    if owner.is_a?(User) && owner == other
      true
    elsif owner.is_a?(Group) && owner.public_send(method, other)
      true
    else
      false
    end
  end
end
