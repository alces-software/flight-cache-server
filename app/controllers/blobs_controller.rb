require 'active_storage/blob'

class BlobsController < ApplicationController
  def download
    redirect_to blob_param.service_url
  end

  def container
    Container.find(params.require(:container_id))
  end

  def blob_param
    container.packages_blobs.find(params.require(:id))
  end
end
