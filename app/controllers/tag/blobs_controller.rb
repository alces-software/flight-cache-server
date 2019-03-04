
module Tag
  class BlobsController < ApplicationController
    load_tag_containers
    before_action do
      @blobs ||= @containers.map(&:blobs).flatten
    end

    def index
      render json: BlobSerializer.new(@blobs)
    end
  end
end
