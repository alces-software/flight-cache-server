
module Tag
  class BlobsController < ApplicationController
    def index
      render json: BlobSerializer.new(
        current_user.containers
                    .where(access_tag: access_tag_param)
                    .map(&:blobs)
                    .flatten
      )
    end
  end
end
