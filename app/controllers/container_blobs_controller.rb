
require 'active_storage/blob'

class ContainerBlobsController < ApplicationController
  def index
    render jsonapi: container.packages_blobs
  end

  def show
    render jsonapi: blob_param
  end

  def download
    redirect_to blob_param.service_url
  end

  private

  def container
    Container.find(params.require(:container_id))
  end

  def blob_param
    container.packages_blobs.find(params.require(:id))
  end
end
