module HasTaggedContainer
  extend ActiveSupport::Concern

  def tag_param
    Tag.find_by_name!(params.require(:tag))
  end

  def current_container
    current_scope_or_user.owns.containers.find_or_create_by(tag: tag_param)
  end

  def current_containers
    current_user.containers.where(tag: tag_param)
  end

  def current_blobs
    if current_scope
      current_scope.owns.blobs
    else
      current_user.blobs
    end
  end
end
