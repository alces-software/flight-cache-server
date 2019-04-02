ScopeParser = Struct.new(:current_user) do
  def parse(scope)
    return nil if scope.blank?
    scope = scope.to_s
    case scope
    when 'user'
      current_user
    when 'group'
      current_user.default_group
    when 'global'
      global_group
    when current_user.email
      current_user
    when current_user.default_group&.name
      current_user.default_group
    else
      parse_admin(scope)
    end.tap do |obj|
      next if obj
      raise InvalidScope, "Could not resolve the scope: #{scope}"
    end
  end

  private

  def parse_admin(scope)
    return nil unless current_user.global_admin?
    User.find_by_email(scope) || Group.find_by_name(scope)
  end

  def global_group
    Group.find_or_create_by!(name: 'global')
  end
end
