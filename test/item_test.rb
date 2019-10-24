# frozen_string_literal: true

require 'test_helper'

class ItemTest < Minitest::Test
    
  TEST_CASES = [
    { 
      name: 'Search Items with multiple EANS',
      response: 'search_items_multiple_eans.json',
      item_count: 10,
      items: [
        { 
          title: "FUNKO POP! Movie Moment: Marvel - Thor vs Thanos",
          asin: 'B07HBBC1M5',
          image_url: 'https://m.media-amazon.com/images/I/51B3xXr-ElL.jpg',
          eans: ["0889698357999", "6952669003752"],
          authors: [],
          artists: [],
          brand: 'Funko',
          model: '35799'
        }
      ]
    },
    {
      name: 'Get ',
      response: 'items_get_B079PQ7T6B.json',
      item_count: 1,
      items: [
        {
          title: "FUNKO POP! Marvel: Avengers Infinity War - Thanos",
          asin: 'B079PQ7T6B',
          image_url: 'https://m.media-amazon.com/images/I/4107DRyNZpL.jpg',
          eans: ["0889698264679", "0615912346988"],
          authors: [],
          artists: ['Funko Pop! Marvel:'],
          brand: 'Funko',
          model: '26467'
        }
      ]
    },
    {
      name: 'Blank Name ',
      response: 'get_item_no_author.json',
      item_count: 1,
      items: [
        {
          asin: "1921878657",
          authors: [],
          artists: [],
          illustrators: []
        }
      ]
    },
    {
      name: 'No Contributors',
      response: 'get_item_no_contributor.json',
      item_count: 1,
      items: [
        {
          asin: "1921878657",
          authors: [],
          illustrators: [],
          artists: []
        }
      ]
    }
  ]
  
  def test_response_parsing
    TEST_CASES.each do |tc|
      
      http_resp = MockHttpResponse.new(File.read(File.join('test/data/', tc[:response])))
      resp = Paapi::Response.new(http_resp)

      assert_equal tc[:item_count], resp.items.count if tc.key?(:item_count)
      
      tc[:items].each_with_index do |item, idx|
        item.keys.each do |exp|
          assert_equal item[exp], resp.items[idx].send(exp)
        end
      end
    end
  end


end