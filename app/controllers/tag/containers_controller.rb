
module Tag
  class ContainersController < ApplicationController
    include HasControllerTag

    def index
      render json: ContainerSerializer.new(
        current_user.containers
                    .where(access_tag: access_tag_param)
      )
    end

    def show
      render json: ContainerSerializer.new(current_container)
    end
  end
end
