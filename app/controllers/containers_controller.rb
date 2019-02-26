class ContainersController < ApplicationController
  def index
    render jsonapi: Container.all
  end
end
