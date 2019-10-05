require 'json'

module Paapi
  class Response
    attr_reader :http_response, :json, :datas, :doc, :items

    def initialize(response)
      @http_response = response
      @json = JSON.parse(response.body.to_s)

      @items_data = @json.dig('ItemsResult', 'Items')
      @items_data ||= @json.dig('SearchResult', 'Items')
      @items_data ||= []

      @items = @items_data.map {|d| Item.new(d)}

    end

    def result_count
      @json.dig('SearchResult', 'TotalResultCount')
    end



  end
end