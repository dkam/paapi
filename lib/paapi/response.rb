require 'json'

module Paapi
  class Response
    attr_reader :http_response, :hash, :datas, :doc, :items

    def initialize(response)
      @http_response = response
      @hash = JSON.parse(response.body.to_s)

      @items_data = @hash.dig('ItemsResult', 'Items')
      @items_data ||= @hash.dig('SearchResult', 'Items')
      @items_data ||= @hash.dig('VariationsResult', 'Items')
      @items_data ||= []

      @items = @items_data.map {|d| Item.new(d)}

    end

    def result_count
      @hash.dig('SearchResult', 'TotalResultCount')
    end
  end
end