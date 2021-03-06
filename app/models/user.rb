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

require 'scope_parser'
require 'errors'
require 'container_join'

class User < ApplicationRecord
  include HasModelContainerJoin

  belongs_to :default_group, optional: true, class_name: 'Group'
  has_many   :containers

  def default_group!
    return default_group if default_group
    raise GroupMissing, 'The user does not have a default group'
  end

  def upload_limit
    super() || Figaro.env.user_upload_limit.to_i
  end

  def used_limit
    joins.owns(admin: false)
         .blobs
         .map(&:byte_size)
         .reduce(0, :+)
  end

  def remaining_limit
    upload_limit - used_limit
  end
end
