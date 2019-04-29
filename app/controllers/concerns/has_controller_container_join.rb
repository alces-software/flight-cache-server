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
# For more information on flight-cache-server, please visit:
# https://github.com/alces-software/flight-cache-server
#===============================================================================

require 'container_join'

module HasControllerContainerJoin
  extend ActiveSupport::Concern

  def resolve_container_join
    ContainerJoin.resolve(
      owner: current_scope_or_user,
      all: current_scope.nil?,
      tag: current_tag,
      admin: admin_request
    )
  end

  class_methods do
    def load_container_from_tag_scope_and_admin(**kwargs)
      before_action(**kwargs) do
        next unless (current_scope && current_tag && !admin_request.nil?)
        @container ||= ContainerJoin.new(current_scope)
                                    .owns_container(current_tag,
                                                    admin: admin_request)
      end
    end
  end
end

