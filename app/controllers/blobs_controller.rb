require 'active_storage/blob'

class BlobsController < ApplicationController
  load_and_authorize_resource :blob, only: [:show, :download]

  # On Index, load the blobs via a container
  only_index = { only: :index }
  load_resource :container, **only_index
  authorize_resource :container, **only_index
  load_and_authorize_resource :blob, through: :container, **only_index

  def index
    serial = BlobSerializer.new(@blobs, is_collection: true)
    render json: serial
  end

  def show
    render json: BlobSerializer.new(@blob)
  end

  def download
    redirect_to @blob.service_url
  end
end
