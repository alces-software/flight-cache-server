ScopeParser = Struct.new(:current_user) do
  def parse(scope)
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
    end
  end

  private

  def global_group
    Group.find_or_create_by!(name: 'global')
  end
end
