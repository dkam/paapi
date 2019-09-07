require 'json'

module AwsPaa
  class Response
    attr_reader :status, :data
    def initialize(response)
      @status = response.status.to_s
      @data = JSON.parse( response.body.to_s )
    end
  end
end