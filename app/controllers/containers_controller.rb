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

class ContainersController < ApplicationController
  include HasControllerContainerJoin

  before_action(only: :index) do
    @containers ||= resolve_container_join.containers
  end

  load_resource :container

  load_and_authorize_resource :blob
  before_action { @container ||= @blob&.container }

  load_container_from_tag_scope_and_admin
  authorize_resource :container

  def index
    render json: ContainerSerializer.new(@containers, is_collection: true)
  end

  def show
    render json: ContainerSerializer.new(@container)
  end

  def upload
    blob = Blob.upload_and_create!(
      io: request.body,
      filename: filename_param,
      container: @container
    )
    render json: BlobSerializer.new(blob)
  end

  private

  def filename_param
    base = params.require(:filename)
    (ext = params[:format]) ? "#{base}.#{ext}" : base
  end
end
