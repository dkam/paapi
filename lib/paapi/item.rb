require 'nameable'
require 'forwardable'

module Paapi
  class Item
    extend Forwardable
    attr_accessor :hash

    def_delegators :@hash, :dig

    def initialize(data)
      @hash = data
    end

    def listings
      get(['Offers', 'Listings'])&.map {|d| Listing.new(d)}
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
      return Date.parse(d) rescue nil
    end

    def release_date
      d = get(%w{ItemInfo ProductInfo ReleaseDate DisplayValue})
      return Date.parse(d) rescue nil
    end

    def contributors
      Array(get(%w{ItemInfo ByLineInfo Contributors}))
    end

    def contributors_of(kind)
      contributors&.select { |e| e['Role'] == kind.to_s.gsub(/([[:alpha:]]+)/).each { |w| w.capitalize } }&.map do |e|
        r = e['Name']
        Nameable(r) unless r.to_s.empty?
      end&.compact
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

    def languages
      get(%w{ItemInfo ContentInfo Languages DisplayValues})
    end

    def original_language
      languages&.find {|l| l['Type'] == 'Original Language' }&.dig('DisplayValue')
    end

    def published_language
      languages&.find {|l| l['Type'] == 'Published' }&.dig('DisplayValue')
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

    def height
      data = get(%w{ItemInfo ProductInfo ItemDimensions Height})
      [data.dig('DisplayValue'), data.dig('Unit')].join(' ')
    end

    def length
      data = get(%w{ItemInfo ProductInfo ItemDimensions Length})
      [data.dig('DisplayValue'), data.dig('Unit')].join(' ')
    end

    def width
      data = get(%w{ItemInfo ProductInfo ItemDimensions Width})
      [data.dig('DisplayValue'), data.dig('Unit')].join(' ')
    end

    def weight
      data = get(%w{ItemInfo ProductInfo ItemDimensions Weight})
      [data.dig('DisplayValue'), data.dig('Unit')].join(' ')
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