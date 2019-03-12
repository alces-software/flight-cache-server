require 'json_web_token'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # http://jsonapi-resources.com/v0.9/guide/basic_usage.html#Application-Controller
  protect_from_forgery with: :null_session

  rescue_from CanCan::AccessDenied do |_err|
    respond_to do |format|
      format.json { head :forbidden }
    end
  end

  class UserMissing < StandardError; end
  rescue_from UserMissing do |_err|
    respond_to do |format|
      format.json do
        err = { "error" => "Missing user credentials" }
        render json: err, status: :unauthorized
      end
    end
  end

  def self.load_tag_containers(**opts)
    before_action(**opts) do
      @containers ||= begin
        Container.where(access_tag: current_tag, group: current_user.groups)
      end
    end
  end

  def current_user
    token_param.user || raise(UserMissing)
  end

  def current_tag
    AccessTag.find_by_name(params.require(:tag))
  end

  def token_param
    token = authenticate_with_http_token { |t| t }
    JsonWebToken::Token.new(token || params[:flight_sso_token])
  end
end
