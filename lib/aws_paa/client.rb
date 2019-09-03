require 'rest-client'

module AwsPaa
  class Client
    def initialize(:access_key, :secret_key, :marketplace, partner_tag: nil, partner_type: 'Associates')
    end
  end
end