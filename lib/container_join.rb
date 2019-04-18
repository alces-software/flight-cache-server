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

ContainerRelationship = Struct.new(:containers) do
  def self.where(**kwargs)
    new(Container.where(**kwargs))
  end

  def tagged(tag)
    self.class.new(containers.where(tag: tag))
  end

  def blobs
    Blob.where(container: containers)
  end

  def labeled_blobs(label, wild: false)
    label_str = ApplicationRecord.sanitize_sql_like(label)
    if wild
      blobs.where('label = ? OR label LIKE ?', label_str, "#{label_str}/%")
    else
      blobs.where(label: label_str)
    end
  end
end

ContainerJoin = Struct.new(:entity) do
  module Mixin
    def joins
      ContainerJoin.new(self)
    end
  end

  module ControllerMixin
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

  def self.global
    new(Group.find_or_create_by!(name: 'global'))
  end

  def self.resolve(owner:, all: true, tag: nil, admin: nil)
    base = if all
      new(owner).all(admin: admin)
    else
      new(owner).owns(admin: admin)
    end
    tag ? base.tagged(tag) : base
  end

  def owns_container(tag, admin: false)
    owns.containers.find_or_create_by(tag: tag, admin: admin)
  end

  def owns(admin: nil)
    where_h = case entity
              when User
                { user: entity }
              when Group
                { group: entity }
              else
                { id: -1 } # Dummy clause that returns an empty relationship
              end
    where_h[:admin] = admin unless admin.nil?
    ContainerRelationship.where(**where_h)
  end

  def all(admin: nil)
    array = [
      self.class.global.owns(admin: admin).containers,
      owns(admin: admin).containers
    ]
    if entity.is_a?(User)
      array << self.class.new(entity.default_group).owns(admin: admin).containers
    end
    containers = array.reduce { |memo, c| memo ? memo.or(c) : c }
    ContainerRelationship.new(containers)
  end
end

