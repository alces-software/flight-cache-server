
class ApplicationError < StandardError; end
class UserMissing < ApplicationError; end
class GroupMissing < ApplicationError; end

class UploadTooLarge < ApplicationError; end
class InvalidScope < ApplicationError; end
