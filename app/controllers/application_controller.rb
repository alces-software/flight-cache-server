require 'json_web_token'
require 'errors'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # http://jsonapi-resources.com/v0.9/guide/basic_usage.html#Application-Controller
  protect_from_forgery with: :null_session

  rescue_from CanCan::AccessDenied do |_err|
    msg = <<~MSG.chomp
      You do not have permission to access this content
    MSG
    render json: { "error" => msg }, status: :forbidden
  end

  rescue_from UserMissing do |_e|
    err = { "error" => "Missing user credentials" }
    render json: err, status: :unauthorized
  end

  rescue_from GroupMissing do |_e|
    err = { "error" => 'You do not have a group' }
    render json: err, status: 404
  end

  rescue_from InvalidScope do |e|
    render json: { 'error' => e.message }, status: 404
  end

  def public_group
    Group.find_by_name('public')
  end

  def current_user
    token_param.user || raise(UserMissing)
  end

  def current_group
    if scope == :public
      public_group
    elsif scope == :group
      current_user.default_group!
    else
      nil
    end
  end

  def scope
    params.permit(:scope)[:scope]&.to_sym.tap do |raw|
      InvalidScope.raise_unless_valid(raw) if raw
    end
  end

  def token_param
    token = authenticate_with_http_token { |t| t }
    JsonWebToken::Token.new(token || params[:flight_sso_token])
  end
end
