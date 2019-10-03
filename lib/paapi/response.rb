require 'json'

module Paapi
  class Response
    attr_reader :http_response, :json, :datas, :doc, :items

    def initialize(response)
      @http_response = response
      @json = JSON.parse(response.body.to_s)

      @datas = symbolise(JSON.parse(response.body.to_s))
      @doc  = JSON.parse(@datas.to_json, object_class: OpenStruct)

      @items_data = @json.dig('ItemsResult', 'Items')
      @items_data ||= @json.dig('SearchResult', 'Items')
      @items_data ||= []

      @items = @items_data.map {|d| Item.new(d)}

    end

    def result_count
      @json.dig('SearchResult', 'TotalResultCount')
    end

    def snake_case(s)
      return s.downcase if s.match(/\A[A-Z]+\z/)

      s.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
      gsub(/([a-z])([A-Z])/, '\1_\2').
      downcase
    end

    def symbolise(obj)
      if obj.is_a? Hash
        return obj.inject({}) do |memo, (k, v)|
          memo.tap { |m| m[snake_case(k)] = symbolise(v) }
        end
      elsif obj.is_a? Array
        return obj.map { |memo| symbolise(memo) }
      end
      obj
    end

  end
end