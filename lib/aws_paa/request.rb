

module AwsPaa
  class Request
    def initialize()
      @request_example = {
        "Keywords": "Harry",
        "Marketplace": "www.amazon.com",
        "PartnerTag": "xyz-20",
        "PartnerType": "Associates",
        "Resources": ["Images.Primary.Small","ItemInfo.Title","Offers.Listings.Price"],
        "SearchIndex": "All"
      }

      @headers = {
        'host' => 'webservices.amazon.com',
        'content-type' => 'application/json; charset=utf-8',
        'content-encoding' => 'amz-1.0',
        'x-amz-date' => '20160925T120000Z',
        'x-amz-target' => 'com.amazon.paapi5.v1.ProductAdvertisingAPIv1.SearchItems',
        'Authorization' => 'AWS4-HMAC-SHA256 Credential=AKIAIOSFODNN7EXAMPLE, SignedHeaders=content-type;host;x-amz-date;x-amz-target, Signature=&5d672d79c15b13162d9279b0855cfba6789a8edb4c82c400e06b5924a6f2b5d7;'
      }

      @marketplaces = [www.amazon.com]
    end

    def get_browse_nodes
      raise NotImplemented
    end

    def get_items
      raise NotImplemented
    end
    
    def get_variations
      raise NotImplemented
    end
    
    def search_items
      raise NotImplemented
    end
  end
end