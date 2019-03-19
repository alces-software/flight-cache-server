
module Tag
  class ContainersController < ApplicationController
    include HasControllerTag

    def index
      render json: ContainerSerializer.new(current_containers)
    end

    def show
      render json: ContainerSerializer.new(current_container)
    end
  end
end
