
require 'active_storage/blob'

class ContainerBlobsController < ApplicationController
  def index
    render jsonapi: container.packages_blobs
  end

  private

  def container
    Container.find(params.require(:container_id))
  end
end
