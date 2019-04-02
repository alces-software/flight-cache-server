ScopeParser = Struct.new(:current_user) do
  def parse(scope)
    case scope
    when :user
      current_user
    when :group
      current_user.default_group
    when :global
      global_group
    end
  end

  private

  def global_group
    Group.find_or_create_by!(name: 'global')
  end
end
