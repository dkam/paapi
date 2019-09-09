require 'json'

module Paapi
  class Response
    attr_reader :http_response, :data
    def initialize(response)
      @http_response = response
      @data = JSON.parse( response.body.to_s )
    end
  end
end