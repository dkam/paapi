# frozen_string_literal: true

require 'forwardable'

module Paapi
  class Listing
    extend Forwardable
    def_delegators :@hash, :dig
    
    attr_accessor :hash
    def initialize(data)
      @hash = data
    end
    
    def availability
      get(%w{Availability Message})
    end
    
    def amazon_fulfilled?
      get(%w{DeliveryInfo IsAmazonFulfilled})
    end
    
    def free_shipping_eligible?
      get(%w{DeliveryInfo IsFreeShippingEligible})
    end
    
    def prime_eligible?
      get(%w{DeliveryInfo IsPrimeEligible})
    end
    
    def price
      get(%w{Price})
    end
    
    def merchant
      get(%w{MerchantInfo Name})
    end

    def condition
      get(%w{Condition Value})
    end
    
    def get(keys)
      @hash.dig(*keys)
    end
    
  end
end