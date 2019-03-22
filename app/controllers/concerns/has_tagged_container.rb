module HasTaggedContainer
  extend ActiveSupport::Concern

  def tag_param
    Tag.find_by_name(params.require(:tag))
  end

  def current_container
    Container.find_by(tag: tag_param, **owner_param_hash)
  end

  def current_containers
    current_user.containers.where(tag: tag_param)
  end

  def current_blobs
    ctr_opt = scope.nil? ? current_containers : current_container
    Blob.where(container: ctr_opt)
  end

  private

  def owner_param_hash
    if current_group
      { group: current_group }
    else
      { user: current_user }
    end
  end
end
