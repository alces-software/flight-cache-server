
module Tag
  class ContainersController < ApplicationController
    def index
      render json: ContainerSerializer.new(
        current_user.containers
                    .where(access_tag: access_tag_param)
      )
    end

    def show
      render json: ContainerSerializer.new(
        Container.where(
          user: current_user,
          access_tag: access_tag_param
        ).first
      )
    end

    def show_group
      render json: ContainerSerializer.new(
        Container.where(
          group: current_user.default_group,
          access_tag: access_tag_param
        ).first
      )
    end
  end
end
