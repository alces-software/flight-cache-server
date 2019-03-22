
module Tagged
  class BlobsController < ApplicationController
    include HasTaggedContainer

    def index
      render json: BlobSerializer.new(current_blobs)
    end
  end
end
