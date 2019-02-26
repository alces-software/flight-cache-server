require 'active_storage/blob'

class BlobsController < ApplicationController
  def download
    redirect_to blob_param.service_url
  end

  def blob_param
    ActiveStorage::Blob.find(params.require(:id))
  end
end
