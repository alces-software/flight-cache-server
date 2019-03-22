class TagsController < ApplicationController
  def index
    render json: TagSerializer.new(Tag.all, is_collection: true)
  end

  def show
    render json: TagSerializer.new(tag_param)
  end

  private

  def tag_param
    Tag.find(params.require(:id))
  end
end
