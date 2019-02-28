class ContainersController < ApplicationController
  def show
    render json: ContainerSerializer.new(container_param)
  end

  private

  def blob_param
    Blob.find(params.require(:blob_id))
  end

  def container_param
    (id = params[:id]) ? Container.find(id) : blob_param.container
  end
end
