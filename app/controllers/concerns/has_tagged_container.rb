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

require 'container_join'

module HasTaggedContainer
  extend ActiveSupport::Concern

  def tag_param
    Tag.find_by_name(tag_name_param) || MissingTagError.raise(tag_name_param)
  end

  def current_container
    ContainerJoin.new(current_scope_or_user)
                 .owns
                 .containers
                 .find_or_create_by(tag: tag_param, admin: admin_request)
  end

  def current_containers
    ContainerJoin.new(current_user)
                 .all(admin: admin_request)
                 .containers
                 .where(tag: tag_param)
  end

  def current_blobs
    if current_scope
      current_container.blobs
    else
      ContainerRelationship.new(current_containers).blobs
    end
  end

  private

  def tag_name_param
    params.require(:tag)
  end
end
