class ContainersController < ApplicationController
  load_resource :container, except: :index
  load_and_authorize_resource :blob, except: :index
  before_action(except: :index) { @container ||= @blob.container }
  authorize_resource :container, except: :index

  def show
    render json: ContainerSerializer.new(@container)
  end

  def upload
    active_storage_blob = ActiveStorage::Blob.create_after_upload!(
      io: request.body, filename: filename_param
    )
    blob = Blob.create!(
      active_storage_blob: active_storage_blob, container: @container
    )
    render json: BlobSerializer.new(blob)
  end

  private

  def filename_param
    base = params.require(:filename)
    (ext = params[:format]) ? "#{base}.#{ext}" : base
  end
end
