class ContainersController < ApplicationController
  def show
    render json: ContainerSerializer.new(container_param)
  end

  private

  def container_param
    Container.find(params.require(:id))
  end
end
