require "paapi/version"

require 'paapi/locales'
require 'paapi/aws_request'
require 'paapi/client'
require 'paapi/response'

module Paapi
  class Error < StandardError; end
  class NotImplemented < StandardError; end
end
