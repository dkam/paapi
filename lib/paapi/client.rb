require 'http'

module Paapi
  class Client
    include AwsRequest
    attr_accessor :marketplace, :partner_tag
    attr_reader :partner_type, :access_key, :secret_key

    def initialize(access_key:, secret_key:, marketplace:, partner_tag: nil, resources: nil, partner_type: 'Associates')
      raise ArgumentError unless MARKETPLACES.keys.include?(marketplace.to_sym)
      @access_key = access_key
      @secret_key = secret_key
      @marketplace = MARKETPLACES[marketplace.to_sym]
      @partner_tag = partner_tag
      @partner_type = partner_type
      @resources = resources || [
        "Images.Primary.Large",
        "ItemInfo.ContentInfo",
        "ItemInfo.ProductInfo",
        "ItemInfo.Title",
        "ItemInfo.ExternalIds",
        "Offers.Listings.Availability.Message",
        "Offers.Listings.Condition",
        "Offers.Listings.Condition.SubCondition",
        "Offers.Listings.DeliveryInfo.IsAmazonFulfilled",
        "Offers.Listings.DeliveryInfo.IsFreeShippingEligible",
        "Offers.Listings.DeliveryInfo.IsPrimeEligible",
        "Offers.Listings.MerchantInfo",
        "Offers.Listings.Price",
        "Offers.Listings.SavingBasis"
      ]
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
