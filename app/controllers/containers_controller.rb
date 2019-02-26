class ContainersController < ApplicationController
  def show
    render jsonapi: Container.find(id_param)
  end

  private

  def id_param
    params.require(:id)
  end
end
