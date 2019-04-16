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

require 'active_storage/blob'
require 'base64'
require 'stringio'
require 'container_join'

class BlobsController < ApplicationController
  wrap_parameters format: :json

  load_and_authorize_resource :container, only: [:index, :create]
  before_action only: :index do
    @blobs ||= if @container
                 @container.blobs
               elsif current_scope
                 ContainerJoin.new(current_scope)
                              .owns(admin: admin_request)
                              .blobs
               else
                 ContainerJoin.new(current_user)
                              .all(admin: admin_request)
                              .blobs
               end
  end

  load_and_authorize_resource :blob

  def index
    render json: BlobSerializer.new(@blobs, is_collection: true)
  end

  def show
    render json: BlobSerializer.new(@blob)
  end

  def create
    b = Blob.upload_and_create!(io: payload_io, container: @container, **blob_params)
    render json: BlobSerializer.new(b)
  end

  def update
    if payload_io
      @blob.upload_and_update!(io: payload_io, **blob_params)
    else
      @blob.update(**blob_params)
    end
    render json: BlobSerializer.new(@blob)
  end

  def download
    redirect_to @blob.service_url
  end

  def destroy
    if @blob.destroy
      render json: BlobSerializer.new(@blob)
    else
      render json: { "error" => @blob.errors.as_json }, status: 400
    end
  end

  private

  def blob_params
    params.require(:blob).permit([:filename, :title]).to_h.symbolize_keys
  end

  def payload_io
    return nil unless params.has_key?(:payload)
    StringIO.new(Base64.decode64(params.require(:payload)))
  end
end
