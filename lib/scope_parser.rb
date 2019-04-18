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

ScopeParser = Struct.new(:current_user) do
  def self.global_group
    ContainerJoin.global.entity
  end

  def self.find_container_scope(container)
    if container.group == global_group
      'global'
    elsif container.group
      'group'
    else
      'user'
    end
  end

  def parse(scope)
    return nil if scope.blank?
    scope = scope.to_s
    case scope
    when 'user'
      current_user
    when 'group'
      current_user.default_group
    when 'global'
      self.class.global_group
    when current_user.email
      current_user
    when current_user.default_group&.name
      current_user.default_group
    else
      parse_admin(scope)
    end.tap do |obj|
      next if obj
      raise InvalidScope, "Could not resolve the scope: #{scope}"
    end
  end

  private

  def parse_admin(scope)
    return nil unless current_user.global_admin?
    User.find_by_email(scope) || Group.find_by_name(scope)
  end
end
