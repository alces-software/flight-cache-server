require 'active_storage/blob'

class BlobsController < ApplicationController
  # Allow indexing blobs against a container or scope
  load_and_authorize_resource :container, only: :index
  before_action only: :index do
    @blobs ||= if @container
                 @container.blobs
               elsif current_scope
                 current_scope.owns.blobs
               else
                 current_user.blobs
               end
  end

  load_and_authorize_resource :blob

  def index
    render json: BlobSerializer.new(@blobs, is_collection: true)
  end

  def show
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
end
