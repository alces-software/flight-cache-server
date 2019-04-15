#==============================================================================
# Copyright (C) 2019-present Alces Flight Ltd.
#
# This file is part of flight-cache-server.
#
# This program and the accompanying materials are made available under
# the terms of the Eclipse Public License 2.0 which is available at
# <https://www.eclipse.org/legal/epl-2.0>, or alternative license
# terms made available by Alces Flight Ltd - please direct inquiries
# about licensing to licensing@alces-flight.com.
#
# This project is distributed in the hope that it will be useful, but
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR
# IMPLIED INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OR CONDITIONS
# OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A
# PARTICULAR PURPOSE. See the Eclipse Public License 2.0 for more
# details.
#
# You should have received a copy of the Eclipse Public License 2.0
# along with this project. If not, see:
#
#  https://opensource.org/licenses/EPL-2.0
#
# For more information on flight-account, please visit:
# https://github.com/alces-software/flight-cache-server
#===============================================================================

require 'json_web_token'
require 'errors'
require 'scope_parser'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # http://jsonapi-resources.com/v0.9/guide/basic_usage.html#Application-Controller
  protect_from_forgery with: :null_session

  before_action :set_paper_trail_whodunnit

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

  rescue_from UploadTooLarge do |e|
    render json: { 'error' => e.message }, status: 413
  end

  rescue_from MissingError do |e|
    render json: { 'error' => e.message }, status: 404
  end

  def current_user
    token_param.user || raise(UserMissing)
  end

  def current_scope
    ScopeParser.new(current_user).parse(scope_param)
  end

  def current_scope_or_user
    current_scope || current_user
  end

  def scope_param
    params.permit(:scope)[:scope]
  end

  def token_param
    token = params[:flight_sso_token]               || \
            authenticate_with_http_token { |t| t }  || \
            cookies[:flight_sso]
    JsonWebToken::Token.new(token)
  end

  def admin_request
    if current_user.global_admin?
      params['admin_request'] || false
    else
      false
    end
  end
end
