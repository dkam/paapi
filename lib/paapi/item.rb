module Paapi
  class Item
    attr_accessor :raw
    def initialize(data)
      @raw = data
    end

    def asin
      get(['ASIN'])
    end

    def detail_url
      get(['DetailPageURL'])
    end

    def image_url
      get(%w{Images Primary Large Height URL})
    end

    def title
      get(%w{ItemInfo Title DisplayValue})
    end

    def contributors
      get(%w{ItemInfo ByLineInfo Contributors})
    end

    def authors
      a = contributors.select { |e| e['Role'] == 'Author' }.map { |e| Nameable(e['Name'])}
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

    def package
      get(%w{ItemInfo TechnicalInfo Formats DisplayValues})
    end

    def kindle?
      !package.nil? && package&.include?('Kindle eBook')
    end

    def get(keys)
      @raw.dig(*keys)
    end

  end
end