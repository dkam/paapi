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

    def market=(a_market)
      @market = a_market
      @marketplace = MARKETPLACES[market.to_sym]
      if !Paapi.partner_market.nil?
        @partner_tag = Paapi.partner_market.dig(a_market) || @partner_tag
      end
    end

    def get_items(item_ids:, **options)
      payload = { ItemIds: Array(item_ids), Resources:  @resources }

      res = do_request(op: :get_items, payload: payload)

      # Errors, ItemResults -> Items -> Item
      return Response.new(res)
    end

    def get_variations(asin:, **options )
      payload = { ASIN: asin, Resources:  @resources }

      res = do_request(op: :get_variations, payload: payload)
      
      # Errors, VariationsResult->Items
       Response.new(res)
    end


    # TODO: Currently we assume Keywords, but we need one of the follow: [Keywords Actor Artist Author Brand Title ]
    def search_items(keywords: nil, **options )
      raise ArgumentError("Missing keywords") unless (options.keys | SEARCH_PARAMS).length.positive?

      search_index = options.dig(:SearchIndex) ||'All'

      payload = { Keywords: keywords, Resources:  @resources, ItemCount: 10, ItemPage: 1, SearchIndex: search_index }.merge(options)

      res = do_request(op: :search_items, payload: payload)

      Response.new(res)
    end

    def get_browse_nodes(browse_node_ids:, **options)
      resources = ['BrowseNodes.Ancestor', 'BrowseNodes.Children']
      payload = { BrowseNodeIds: Array(browse_node_ids), Resources:  @resources }.merge(options)

      res = do_request(op: :get_browse_nodes, payload: payload)

      Response.new(res)
    end
  end
end
