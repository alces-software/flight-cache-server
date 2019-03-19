
module Tag
  class ContainersController < ApplicationController
    def index
      render json: ContainerSerializer.new(
        current_user.containers
                    .where(access_tag: access_tag_param)
      )
    end
  end
end
