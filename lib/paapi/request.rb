require 'byebug'

module Paapi
  class Request
    include AwsRequest
    attr_accessor :client, :marketplace, :resources, :payload, :service, :partner_type
    attr_reader :partner_tag

    def initialize(client:, resources: nil)
      @client      = client
      @marketplace = client.marketplace
      @partner_tag = client.partner_tag
      @partner_type = 'Associates'

      @resources = resources || [
        "Images.Primary.Large",
        "ItemInfo.ContentInfo",
        "ItemInfo.ProductInfo",
        "ItemInfo.Title",
        "ItemInfo.ExternalIds",
      ]
    end

    def get_items(item_ids:,  **options)
      item_ids = Array(item_ids)

      payload = { ItemIds: item_ids, Resources:  @resources }

      do_request(op: :get_items, payload: payload)
    end

    def get_variations(asin:)
      payload = { ASIN: asin, Resources:  @resources }

      do_request(op: :get_variations, payload: payload)
    end

    def search_items(keywords: )
      payload = { Keywords: keywords, Resources:  @resources }

      do_request(op: :search_items, payload: payload)
    end

    def get_browse_nodes
      raise NotImplemented
    end
  end
end