
module Tag
  class BlobsController < ApplicationController
    include HasControllerTag

    def index
      render json: BlobSerializer.new(current_blobs)
    end
  end
end
