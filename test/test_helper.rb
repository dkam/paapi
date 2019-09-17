$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'paapi'
require 'byebug'
require 'minitest/autorun'

class MockHttpResponse
  attr_accessor :body
  def initialize(body)
    @body = body
  end
end
