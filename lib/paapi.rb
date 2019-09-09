require "paapi/version"

require 'paapi/locales'
require 'paapi/aws_request'
require 'paapi/client'
require 'paapi/response'

module Paapi
  class Error < StandardError; end
  class NotImplemented < StandardError; end

  class << self
    attr_accessor :access_key,
                  :secret_key,
                  :partner_tag,
                  :partner_type,
                  :marketplace,
                  :test_mode

    def configure
      yield self
      true
    end
    alias_method :config, :configure
  end
end
