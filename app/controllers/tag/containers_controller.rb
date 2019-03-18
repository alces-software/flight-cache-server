
module Tag
  class ContainersController < ApplicationController
    load_tag_containers

    def index
      render json: ContainerSerializer.new(@containers)
    end
  end
end
