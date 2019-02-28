require 'active_storage/blob'

class BlobsController < ApplicationController
  load_and_authorize_resource

  def index
    serial = BlobSerializer.new(container_param.blobs, is_collection: true)
    render json: serial
  end

  def show
    render json: BlobSerializer.new(blob_param)
  end

  def upload
    filename_param
    container_param
    active_storage_blob = ActiveStorage::Blob.create_after_upload!(
      io: request.body, filename: filename_param
    )
    blob = Blob.create!(
      active_storage_blob: active_storage_blob, container: container_param
    )
    render json: BlobSerializer.new(blob)
  end

  def download
    redirect_to ActiveStorage::Blob.find(params.require(:id)).service_url
  end

  private

  def blob_param
    Blob.find(params.require(:id))
  end

  def filename_param
    base = params.require(:filename)
    (ext = params[:format]) ? "#{base}.#{ext}" : base
  end

  def container_param
    Container.find(params.require(:container_id))
  end
end
