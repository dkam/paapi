require 'http'

module AwsPaa
  class Client
    attr_accessor :marketplace, :partner_tag
    attr_reader :partner_type, :access_key, :secret_key

    def initialize(access_key:, secret_key:, marketplace:, partner_tag: nil, partner_type: 'Associates')
      raise ArgumentError unless MARKETPLACES.keys.include?(marketplace.to_sym)
      @access_key = access_key
      @secret_key = secret_key
      @marketplace = MARKETPLACES[marketplace.to_sym]
      @partner_tag = partner_tag
      @partner_type = partner_type
    end

    def get_items(item_ids: )[]
      Request.new(client: self).get_items(item_ids: item_ids)
    end

    def get_variations(asin: )
      Request.new(client: self).get_variations(asin: asin)
    end

    def search_items(keywords: )
      Request.new(client: self).search_items(keywords: keywords)
    end

    def get_browse_nodes
      Request.new(client: self).get_browse_nodes(keywords: keywords)
    end
  end
end
