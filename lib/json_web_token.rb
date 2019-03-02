#==============================================================================
# Copyright (C) 2016 Stephen F Norledge & Alces Software Ltd.
#
# This file is part of Alces FlightDeck.
#
# All rights reserved, see LICENSE.txt.
#==============================================================================
#
# Based on code taken from
# http://zacstewart.com/2015/05/14/using-json-web-tokens-to-authenticate-javascript-front-ends-on-rails.html
#
require 'jwt'

class JsonWebToken
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

    def user
      User.find_by_email(email)
    end

    private

    def data
      @data ||= JsonWebToken.decode(token).deep_symbolize_keys
    rescue
      @error ||= true
      @data ||= {}
    end
  end

  Builder = Struct.new(:user) do
    def build(expire = 24.hours.from_now)
      JsonWebToken.encode({
        email: user.email
      }, expire)
    end
  end

  def self.enabled?
    Figaro.env.json_web_token_secret.present?
  end

  def self.encode(payload, expiration = 24.hours.from_now)
    payload = payload.dup
    payload['exp'] = expiration.to_i
    JWT.encode(
      payload,
      Figaro.env.json_web_token_secret,
      'HS256'
    )
  end

  def self.decode(token)
    JWT.decode(
      token,
      Figaro.env.json_web_token_secret,
      true,
      { algorithm: 'HS256' }
    ).first
  end
end
