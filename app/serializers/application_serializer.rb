class ApplicationSerializer
  include FastJsonapi::ObjectSerializer

  def self.urls
    Rails.application.routes.url_helpers
  end
end
