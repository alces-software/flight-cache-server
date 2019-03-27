class ContainersController < ApplicationController
  before_action(only: :index) do
    @containers ||= if current_scope
                      current_scope.owns.containers
                    else
                      current_user.containers
                    end
  end
  load_resource :container
  load_and_authorize_resource :blob
  before_action { @container ||= @blob&.container }
  authorize_resource :container

  def index
    render json: ContainerSerializer.new(@containers, is_collection: true)
  end

  def show
    render json: ContainerSerializer.new(@container)
  end

  def upload
    blob = Blob.upload_and_create!(
      io: request.body,
      filename: filename_param,
      container: @container
    )
    render json: BlobSerializer.new(blob)
  end

  private

  def filename_param
    base = params.require(:filename)
    (ext = params[:format]) ? "#{base}.#{ext}" : base
  end
end
