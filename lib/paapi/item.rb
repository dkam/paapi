require 'nameable'

module Paapi
  class Item
    attr_accessor :hash
    def initialize(data)
      @hash = data
    end

    def listings
      get(['Offers', 'Listings']).map {|d| Listing.new(d)}
    end

    def asin
      get(['ASIN'])
    end

    def detail_url
      get(['DetailPageURL'])
    end

    def image_url
      get(%w{Images Primary Large URL})
    end

    def title
      get(%w{ItemInfo Title DisplayValue})
    end

    def manufacturer
      get(%w{ItemInfo ByLineInfo Manufacturer DisplayValue})
    end

    def publisher
      manufacturer
    end

    def publication_date
      d = get(%w{ItemInfo ContentInfo PublicationDate DisplayValue})
      return d.nil? ? nil : Date.parse(d)
    end

    def release_date
      d = get(%w{ItemInfo ProductInfo ReleaseDate DisplayValue})
      return d.nil? ? nil : Date.parse(d)
    end

    def contributors
      get(%w{ItemInfo ByLineInfo Contributors})
    end

    def contributors_of(kind)
      contributors&.select { |e| e['Role'] == kind.to_s.gsub(/([[:alpha:]]+)/) { |w| w.capitalize } }&.map { |e| Nameable(e['Name'])}
    end

    def actors
      contributors_of 'Actor'
    end

    def artists
      contributors_of 'Artist'
    end

    def authors
      contributors_of 'Author'
    end

    def illustrators
      contributors_of 'Illustrator'
    end

    def narrators
      contributors_of 'Narrator'
    end

    def publishers
      contributors_of 'Publisher'
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

    def brand
      get(%w{ItemInfo ByLineInfo Brand DisplayValue})
    end

    def part_number
      get(%w{ItemInfo ManufactureInfo ItemPartNumber DisplayValue})
    end

    def model
      get(%w{ItemInfo ManufactureInfo Model DisplayValue})
    end

    def package
      get(%w{ItemInfo TechnicalInfo Formats DisplayValues})
    end

    def kindle?
      !package.nil? && package&.include?('Kindle eBook')
    end

    def get(keys)
      @hash.dig(*keys)
    end

    def self.to_items(data)
      data.map {|d| Item.new(d)}
    end

  end
end