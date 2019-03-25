require 'active_storage/blob'

class BlobsController < ApplicationController
  load_and_authorize_resource :blob, only: [:show, :download]

  # Allow indexing blobs against a contaier
  load_and_authorize_resource :container, only: :index

  def index
    blobs = if @container
              @container.blobs
            else
              current_user.blobs
            end
    render json: BlobSerializer.new(blobs, is_collection: true)
  end

  def show
    render json: BlobSerializer.new(@blob)
  end

  def download
    redirect_to @blob.service_url
  end
end
