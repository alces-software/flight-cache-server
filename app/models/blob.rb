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

class Blob < ApplicationRecord
  def self.upload_and_create!(io:, filename:, container:)
    container.raise_if_exceeds_max_size(io)
    transaction do
      as = ActiveStorage::Blob.create_after_upload!(io: io, filename: filename)
      create!(active_storage_blob: as, container: container)
    end
  end

  belongs_to :container
  belongs_to :active_storage_blob, class_name: 'ActiveStorage::Blob'
  delegate_missing_to :active_storage_blob

  alias_attribute :protected?, :protected

  after_destroy :purge_active_storage_blob

  def protected
    super() || container.restricted?
  end

  def readable?(other)
    access?(:readable?, other)
  end

  def writable?(other)
    return false if self.protected?
    access?(:writable?, other)
  end

  private

  def purge_active_storage_blob
    active_storage_blob.purge
  end

  def access?(method, other)
    container.public_send(method, other)
  end
end
