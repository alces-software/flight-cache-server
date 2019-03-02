require 'active_storage/blob'

class BlobsController < ApplicationController
  load_and_authorize_resource :blob, only: [:show, :download]
  load_and_authorize_resource :container, only: :index
  load_and_authorize_resource :blob, through: :container, only: :index

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
