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

  def upload
    filename_param
    active_storage_blob = ActiveStorage::Blob.create_after_upload!(
      io: request.body, filename: filename_param
    )
    blob = Blob.create!(
      active_storage_blob: active_storage_blob, container: @container
    )
    render json: BlobSerializer.new(blob)
  end

  def download
    redirect_to @blob.service_url
  end

  private

  def filename_param
    base = params.require(:filename)
    (ext = params[:format]) ? "#{base}.#{ext}" : base
  end
end
