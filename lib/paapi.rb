require 'paapi/version'

require 'paapi/client'
require 'paapi/item'
require 'paapi/listing'
require 'paapi/response'

module Paapi
  class Error < StandardError; end
  class NotImplemented < StandardError; end
  SEARCH_PARAMS = %i[keywords actor, artist, author, brand title].freeze
  DEFAULT_PARTNER_TYPE = 'Associates'
  DEFAULT_MARKET = :us
  DEFAULT_CONDITION  = 'Any'
  DEFAULT_RESOURCES = [
    'Images.Primary.Large',
    'ItemInfo.ByLineInfo',
    'ItemInfo.ContentInfo',
    'ItemInfo.ExternalIds',
    'ItemInfo.Features',
    'ItemInfo.ManufactureInfo',
    'ItemInfo.ProductInfo',
    'ItemInfo.TechnicalInfo', # Includes format when Kindle
    'ItemInfo.Title',
    'ItemInfo.TradeInInfo',
    'Offers.Listings.Availability.Message',
    'Offers.Listings.Condition',
    'Offers.Listings.Condition.SubCondition',
    'Offers.Listings.DeliveryInfo.IsAmazonFulfilled',
    'Offers.Listings.DeliveryInfo.IsFreeShippingEligible',
    'Offers.Listings.DeliveryInfo.IsPrimeEligible',
    'Offers.Listings.MerchantInfo',
    'Offers.Listings.Price',
    'Offers.Listings.SavingBasis'
  ].freeze

  Locale = Struct.new(:key, :name, :host, :region) do
    def site
      host.sub('webservices', 'www')
    end
  end

  MARKETPLACES = {
    au: Locale.new(:au, 'Australia',	          'webservices.amazon.com.au', 'us-west-2'),
    br: Locale.new(:br, 'Brazil',	              'webservices.amazon.com.br'	 'us-east-1'),
    ca: Locale.new(:ca, 'Canada',	              'webservices.amazon.ca',	   'us-east-1'),
    fr: Locale.new(:fr, 'France',	              'webservices.amazon.fr',	   'eu-west-1'),
    de: Locale.new(:de, 'Germany',	            'webservices.amazon.de',	   'eu-west-1'),
    in: Locale.new(:in, 'India',	              'webservices.amazon.in',	   'eu-west-1'),
    it: Locale.new(:it, 'Italy',	              'webservices.amazon.it',	   'eu-west-1'),
    jp: Locale.new(:jp, 'Japan',	              'webservices.amazon.co.jp',	 'us-west-2'),
    mx: Locale.new(:mx, 'Mexico',	              'webservices.amazon.com.mx', 'us-east-1'),
    es: Locale.new(:es, 'Spain',                'webservices.amazon.es',	   'eu-west-1'),
    tr: Locale.new(:tk, 'Turkey',	              'webservices.amazon.com.tr', 'eu-west-1'),
    ae: Locale.new(:ae, 'United Arab Emirates',	'webservices.amazon.ae',	   'eu-west-1'),
    uk: Locale.new(:uk, 'United Kingdom',	      'webservices.amazon.co.uk',	 'eu-west-1'),
    us: Locale.new(:us, 'United States',	      'webservices.amazon.com',	   'us-east-1'),
  }.freeze

  Operation = Struct.new(:target_name, :endpoint_suffix, :http_method, :service )

  OPERATIONS = {
    get_browse_nodes: Operation.new( 'GetBrowseNodes', 'getbrowsenodes', 'POST', 'ProductAdvertisingAPI' ),
    get_items:        Operation.new( 'GetItems',       'getitems',       'POST', 'ProductAdvertisingAPI' ),
    get_variations:   Operation.new( 'GetVariations',  'getvariations',  'POST', 'ProductAdvertisingAPI' ),
    search_items:     Operation.new( 'SearchItems',    'searchitems',    'POST', 'ProductAdvertisingAPI' )
  }.freeze

  class << self
    attr_accessor :access_key,
                  :secret_key,
                  :partner_tag,
                  :partner_type,
                  :market,
                  :partner_market,
                  :condition,
                  :resources,
                  :test_mode

    def configure
      yield self
      true
    end
    alias_method :config, :configure
  end

  def symbolize_keys(hash)
    Hash[hash.map{|k,v| v.is_a?(Hash) ? [k.to_sym, symbolize_keys(v)] : [k.to_sym, v] }]
  end
end

