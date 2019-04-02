ScopeParser = Struct.new(:current_user) do
  def parse(scope)
    if scope == :user
      current_user
    end
  end
end
