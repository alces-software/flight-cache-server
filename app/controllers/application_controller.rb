require 'json_web_token'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # http://jsonapi-resources.com/v0.9/guide/basic_usage.html#Application-Controller
  protect_from_forgery with: :null_session

  Token = Struct.new(:token) do
    def initialize(*a)
      super
      data
    end

    def error?
      @error
    end

    def email
      data[:email]
    end

    private

    def data
      @data ||= JsonWebToken.decode(token).deep_symbolize_keys
    rescue
      @error ||= true
      @data ||= {}
    end
  end

  def current_user
    User.find_by_email(token_param.email)
  end

  def token_param
    Token.new(params[:flight_sso_token])
  end
end
