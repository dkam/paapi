require 'paapi/version'

require 'paapi/locales'
require 'paapi/aws_request'
require 'paapi/client'
require 'paapi/response'

module Paapi
  class Error < StandardError; end
  class NotImplemented < StandardError; end
  SEARCH_PARAMS = %i[keywords actor, artist, author, brand title].freeze
  DEFAULT_PARTNER_TYPE = 'Associates'
  DEFAULT_MARKET = :us
  DEFAULT_RESOURCES = [
    'Images.Primary.Large',
    'ItemInfo.ContentInfo',
    'ItemInfo.ProductInfo',
    'ItemInfo.Title',
    'ItemInfo.ExternalIds',
    'Offers.Listings.Availability.Message',
    'Offers.Listings.Condition',
    'Offers.Listings.Condition.SubCondition',
    'Offers.Listings.DeliveryInfo.IsAmazonFulfilled',
    'Offers.Listings.DeliveryInfo.IsFreeShippingEligible',
    'Offers.Listings.DeliveryInfo.IsPrimeEligible',
    'Offers.Listings.MerchantInfo',
    'Offers.Listings.Price',
    'Offers.Listings.SavingBasis'
  ]

  class << self
    attr_accessor :access_key,
                  :secret_key,
                  :partner_tag,
                  :partner_type,
                  :market,
                  :partner_market,
                  :resources,
                  :test_mode

    def configure
      yield self
      true
    end
    alias_method :config, :configure
  end
end
