module HasControllerTag
  extend ActiveSupport::Concern

  def access_tag_param
    AccessTag.find_by_name(params.require(:tag))
  end

  def current_container
    Container.where(access_tag: access_tag_param, **owner_param_hash).first
  end

  def current_containers
    current_user.containers.where(access_tag: access_tag_param)
  end

  def current_blobs
    containers = if params[:list_all_tagged_blobs]
                   current_containers
                 else
                   current_container
                 end
    Blob.where(container: containers)
  end

  private

  def owner_param_hash
    if params[:group]
      { group: current_user.default_group }
    else
      { user: current_user }
    end
  end
end
