require 'http'

module Paapi
  class Client
    include AwsRequest
    attr_accessor :partner_tag, :marketplace, :resources
    attr_reader :partner_type, :access_key, :secret_key, :market

    def initialize(access_key:   Paapi.access_key,
                   secret_key:   Paapi.secret_key,
                   partner_tag:  Paapi.partner_tag,
                   market:       Paapi.market || DEFAULT_MARKET,
                   resources:    Paapi.resources || DEFAULT_RESOURCES,
                   partner_type: DEFAULT_PARTNER_TYPE
                  )
      raise ArgumentError unless MARKETPLACES.keys.include?(market.to_sym)
      @access_key = access_key
      @secret_key = secret_key
      @partner_type = partner_type
      @resources = resources unless resources.nil?

      self.market = market
      @partner_tag = partner_tag if !partner_tag.nil?      
    end

    def market=(_market)
      @market = _market
      @marketplace = MARKETPLACES[market.to_sym]
      if !Paapi.partner_market.nil?
        @partner_tag = Paapi.partner_market.dig(_market) || @partner_tag
      end
    end
    

    def get_items(item_ids:, **options)
      item_ids = Array(item_ids)

      payload = { ItemIds: item_ids, Resources:  @resources }

      res = do_request(op: :get_items, payload: payload)

      Response.new(res)
    end

    def get_variations(asin:, **options )
      payload = { ASIN: asin, Resources:  @resources }

      res = do_request(op: :get_variations, payload: payload)
      Response.new(res)
    end

    def search_items(keywords:, **options )
      search_index = 'All'

      # %i[Keywords Actor Artist Author Brand Title ]

      payload = { Keywords: keywords, Resources:  @resources, ItemCount: 10, ItemPage: 1, SearchIndex: search_index }.merge(options)

      res = do_request(op: :search_items, payload: payload)

      Response.new(res)
    end

    def get_browse_nodes(keywords:, **options)
      raise NotImplemented
      #Response.new(Request.new(client: self).get_browse_nodes(keywords: keywords, **options))
    end
  end
end
