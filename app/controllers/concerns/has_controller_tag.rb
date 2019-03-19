module HasControllerTag
  extend ActiveSupport::Concern

  def access_tag_param
    AccessTag.find_by_name(params.require(:tag))
  end

  def current_container
    Container.where(access_tag: access_tag_param, **owner_param_hash).first
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
