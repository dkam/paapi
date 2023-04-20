require 'net/http/persistent'
require 'aws-sigv4'

module Paapi
  class Client

    attr_accessor :partner_tag, :marketplace, :resources, :condition
    attr_reader :partner_type, :access_key, :secret_key, :market, :http

    def initialize(access_key:   Paapi.access_key,
                   secret_key:   Paapi.secret_key,
                   partner_tag:  Paapi.partner_tag,
                   market:       Paapi.market     || DEFAULT_MARKET,
                   condition:    Paapi.condition  || DEFAULT_CONDITION,
                   resources:    Paapi.resources  || DEFAULT_RESOURCES,
                   partner_type: DEFAULT_PARTNER_TYPE
                  )
      raise ArgumentError unless MARKETPLACES.keys.include?(market.to_sym)

      @access_key = access_key
      @secret_key = secret_key
      @partner_type = partner_type
      @resources = resources unless resources.nil?
      @condition = condition  
      self.market = market
      @partner_tag = partner_tag if !partner_tag.nil?

      @http = Net::HTTP::Persistent.new name: 'paapi'
    end

    def market=(a_market)
      @market = a_market
      @marketplace = MARKETPLACES[market.to_sym]
      if !Paapi.partner_market.nil?
        @partner_tag = Paapi.partner_market.dig(a_market.to_sym) || @partner_tag
      end
    end

    def get_items(item_ids:, **options)
      payload = { ItemIds: Array(item_ids), Resources:  @resources }.merge(options)
      request(op: :get_items, payload: payload)
    end

    def get_variations(asin:, **options )
      payload = { ASIN: asin, Resources:  @resources }.merge(options)
      request(op: :get_variations, payload: payload)
    end

    # TODO: Currently we assume Keywords, but we need one of the following: [Keywords Actor Artist Author Brand Title ]
    def search_items(keywords: nil, **options )
      raise ArgumentError("Missing keywords") unless (options.keys | SEARCH_PARAMS).length.positive?

      search_index = options.dig(:SearchIndex) ||'All'

      payload = { Keywords: keywords, Resources:  @resources, ItemCount: 10, ItemPage: 1, SearchIndex: search_index }.merge(options)

      request(op: :search_items, payload: payload)
    end

    def get_browse_nodes(browse_node_ids:, **options)
      payload = { BrowseNodeIds: Array(browse_node_ids), Resources:  @resources }.merge(options)
      request(op: :get_browse_nodes, payload: payload)
    end
    
    private
    
    def request(op:,  payload:)
      raise ArguemntError unless Paapi::OPERATIONS.keys.include?(op)
      
      operation = OPERATIONS[op]

      headers = {
        'X-Amz-Target' => "com.amazon.paapi5.v1.ProductAdvertisingAPIv1.#{operation.target_name}",
        'Content-Encoding' => 'amz-1.0',
      }

      default_payload = {
        'Condition' => condition,
        'PartnerTag' => partner_tag,
        'PartnerType' => partner_type,
        'Marketplace' => marketplace.site
      }

      payload = default_payload.merge(payload)

      endpoint =  "https://#{marketplace.host}/paapi5/#{operation.endpoint_suffix}"

      signer = Aws::Sigv4::Signer.new(
        service: operation.service,
        region: marketplace.region,
        access_key_id: access_key,
        secret_access_key: secret_key,
        http_method: operation.http_method,
        endpoint: marketplace.host
      )

      signature = signer.sign_request(http_method: operation.http_method, url: endpoint, headers: headers, body: payload.to_json)

      headers['Host'] = marketplace.host
      headers['X-Amz-Date'] = signature.headers['x-amz-date']
      headers['X-Amz-Content-Sha256']= signature.headers['x-amz-content-sha256']
      headers['Authorization'] = signature.headers['authorization']
      headers['Content-Type'] = 'application/json; charset=utf-8'

      Response.new( post(url: endpoint, body: payload, headers: headers))
    end

    def post(url:, body:, headers:)
      uri = URI.parse(url)

      post_request = Net::HTTP::Post.new(uri.path)
      post_request.content_type = 'application/json; charset=UTF-8'
      
      headers.each { |k, v| post_request[k] = v }
      post_request.body = body.to_json

      http.request uri, post_request

    end
  end
end
