
class ApplicationError < StandardError; end
class UserMissing < ApplicationError; end
class GroupMissing < ApplicationError; end
class InvalidScope < ApplicationError
  SCOPES = [:user, :group, :public]

  def self.raise_unless_valid(scope)
    return if SCOPES.include?(scope)
    msg = <<~ERROR.squish
      '#{scope}' is not a valid scope! The valid scopes are:
      #{SCOPES.map(&:to_s)}
    ERROR
    raise new(msg)
  end
end
