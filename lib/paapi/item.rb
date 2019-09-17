module Paapi
  class Item
    attr_accessor :raw
    def initialize(data)
      @raw = data
    end
    
    def asin
      get(['ASIN'])
    end
    
    def title
      get(%w{ItemInfo Title DisplayValue})
    end
    
    def release_date
      get(%w{ItemInfo ReleaseDate})
    end
    
    def eans
      get(%w{ItemInfo ExternalIds EANs DisplayValues})
    end
    
    def upcs
      get(%w{ItemInfo ExternalIds UPCs DisplayValues})
    end
    
    def features
      get(%w{ItemInfo Features DisplayValues})&.join(' ')
    end
    
    def part_number
      get(%w{ItemInfo ManufactureInfo ItemPartNumber DisplayValue})
    end

    def format
      get(%w{ItemInfo TechnicalInfo Formats DisplayValues})
    end
    
    def kindle?
      !format.nil? && format&.include?('Kindle eBook')
    end
    
    def get(keys)
      @raw.dig(*keys)
    end

  end
end