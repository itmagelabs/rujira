# frozen_string_literal: true

module Rujira
  # TODO
  class Connection
    def initialize
      @token = Configuration.token
      @options = {
        url: Configuration.url
      }
    end

    def run
      Faraday.new(@options) do |builder|
        builder.request :authorization, 'Bearer', -> { @token }
        builder.request :multipart, flat_encode: true
        builder.request :json
        builder.response :json
        builder.response :raise_error
        builder.response :logger if Configuration.debug
      end
    end
  end
end
