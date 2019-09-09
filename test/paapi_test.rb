require "test_helper"

class PaapiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Paapi::VERSION
  end

  def test_it_does_something_useful
    assert false
  end

  def test_json_payload_generation
    payload = {
      "Keywords": "9781473619814",
      "Resources": [
       "Images.Primary.Large",
       "ItemInfo.ByLineInfo",
       "ItemInfo.ContentInfo",
       "ItemInfo.ContentRating",
       "ItemInfo.Classifications",
       "ItemInfo.ExternalIds",
       "ItemInfo.Features",
       "ItemInfo.ManufactureInfo",
       "ItemInfo.ProductInfo",
       "ItemInfo.TechnicalInfo",
       "ItemInfo.Title",
       "ItemInfo.TradeInInfo",
       "Offers.Listings.Availability.MaxOrderQuantity",
       "Offers.Listings.Availability.Message",
       "Offers.Listings.Availability.MinOrderQuantity",
       "Offers.Listings.Availability.Type",
       "Offers.Listings.Condition",
       "Offers.Listings.Condition.SubCondition",
       "Offers.Listings.DeliveryInfo.IsAmazonFulfilled",
       "Offers.Listings.DeliveryInfo.IsFreeShippingEligible",
       "Offers.Listings.DeliveryInfo.IsPrimeEligible",
       "Offers.Listings.DeliveryInfo.ShippingCharges",
       "Offers.Listings.IsBuyBoxWinner",
       "Offers.Listings.LoyaltyPoints.Points",
       "Offers.Listings.MerchantInfo",
       "Offers.Listings.Price",
       "Offers.Listings.ProgramEligibility.IsPrimeExclusive",
       "Offers.Listings.ProgramEligibility.IsPrimePantry",
       "Offers.Listings.Promotions",
       "Offers.Listings.SavingBasis",
       "Offers.Summaries.HighestPrice",
       "Offers.Summaries.LowestPrice",
       "Offers.Summaries.OfferCount"
      ],
      "PartnerTag": "booko01-22",
      "PartnerType": "Associates",
      "Marketplace": "www.amazon.com.au",
      "Operation": "SearchItems"
    }

    headers = %q{Host: webservices.amazon.com.au
      X-Amz-Date: 20190903T014126Z
      X-Amz-Target: com.amazon.paapi5.v1.ProductAdvertisingAPIv1.SearchItems
      Content-Encoding: amz-1.0}
      
    request = %q{https://webservices.amazon.com.au/!YW16LTEuMDtjb20uYW1hem9uLnBhYXBpNS52MS5Qcm9kdWN0QWR2ZXJ0aXNpbmdBUEl2MS5TZWFyY2hJdGVtczt7CiAgICAiS2V5d29yZHMiOiAiOTc4MTQ3MzYxOTgxNCIsCiAgICAiUmVzb3VyY2VzIjogWwogICAgICAgICJJbWFnZXMuUHJpbWFyeS5MYXJnZSIsCiAgICAgICAgIkl0ZW1JbmZvLkJ5TGluZUluZm8iLAogICAgICAgICJJdGVtSW5mby5Db250ZW50SW5mbyIsCiAgICAgICAgIkl0ZW1JbmZvLkNvbnRlbnRSYXRpbmciLAogICAgICAgICJJdGVtSW5mby5DbGFzc2lmaWNhdGlvbnMiLAogICAgICAgICJJdGVtSW5mby5FeHRlcm5hbElkcyIsCiAgICAgICAgIkl0ZW1JbmZvLkZlYXR1cmVzIiwKICAgICAgICAiSXRlbUluZm8uTWFudWZhY3R1cmVJbmZvIiwKICAgICAgICAiSXRlbUluZm8uUHJvZHVjdEluZm8iLAogICAgICAgICJJdGVtSW5mby5UZWNobmljYWxJbmZvIiwKICAgICAgICAiSXRlbUluZm8uVGl0bGUiLAogICAgICAgICJJdGVtSW5mby5UcmFkZUluSW5mbyIsCiAgICAgICAgIk9mZmVycy5MaXN0aW5ncy5BdmFpbGFiaWxpdHkuTWF4T3JkZXJRdWFudGl0eSIsCiAgICAgICAgIk9mZmVycy5MaXN0aW5ncy5BdmFpbGFiaWxpdHkuTWVzc2FnZSIsCiAgICAgICAgIk9mZmVycy5MaXN0aW5ncy5BdmFpbGFiaWxpdHkuTWluT3JkZXJRdWFudGl0eSIsCiAgICAgICAgIk9mZmVycy5MaXN0aW5ncy5BdmFpbGFiaWxpdHkuVHlwZSIsCiAgICAgICAgIk9mZmVycy5MaXN0aW5ncy5Db25kaXRpb24iLAogICAgICAgICJPZmZlcnMuTGlzdGluZ3MuQ29uZGl0aW9uLlN1YkNvbmRpdGlvbiIsCiAgICAgICAgIk9mZmVycy5MaXN0aW5ncy5EZWxpdmVyeUluZm8uSXNBbWF6b25GdWxmaWxsZWQiLAogICAgICAgICJPZmZlcnMuTGlzdGluZ3MuRGVsaXZlcnlJbmZvLklzRnJlZVNoaXBwaW5nRWxpZ2libGUiLAogICAgICAgICJPZmZlcnMuTGlzdGluZ3MuRGVsaXZlcnlJbmZvLklzUHJpbWVFbGlnaWJsZSIsCiAgICAgICAgIk9mZmVycy5MaXN0aW5ncy5EZWxpdmVyeUluZm8uU2hpcHBpbmdDaGFyZ2VzIiwKICAgICAgICAiT2ZmZXJzLkxpc3RpbmdzLklzQnV5Qm94V2lubmVyIiwKICAgICAgICAiT2ZmZXJzLkxpc3RpbmdzLkxveWFsdHlQb2ludHMuUG9pbnRzIiwKICAgICAgICAiT2ZmZXJzLkxpc3RpbmdzLk1lcmNoYW50SW5mbyIsCiAgICAgICAgIk9mZmVycy5MaXN0aW5ncy5QcmljZSIsCiAgICAgICAgIk9mZmVycy5MaXN0aW5ncy5Qcm9ncmFtRWxpZ2liaWxpdHkuSXNQcmltZUV4Y2x1c2l2ZSIsCiAgICAgICAgIk9mZmVycy5MaXN0aW5ncy5Qcm9ncmFtRWxpZ2liaWxpdHkuSXNQcmltZVBhbnRyeSIsCiAgICAgICAgIk9mZmVycy5MaXN0aW5ncy5Qcm9tb3Rpb25zIiwKICAgICAgICAiT2ZmZXJzLkxpc3RpbmdzLlNhdmluZ0Jhc2lzIiwKICAgICAgICAiT2ZmZXJzLlN1bW1hcmllcy5IaWdoZXN0UHJpY2UiLAogICAgICAgICJPZmZlcnMuU3VtbWFyaWVzLkxvd2VzdFByaWNlIiwKICAgICAgICAiT2ZmZXJzLlN1bW1hcmllcy5PZmZlckNvdW50IgogICAgXSwKICAgICJQYXJ0bmVyVGFnIjogImJvb2tvMDEtMjIiLAogICAgIlBhcnRuZXJUeXBlIjogIkFzc29jaWF0ZXMiLAogICAgIk1hcmtldHBsYWNlIjogInd3dy5hbWF6b24uY29tLmF1Igp9}

    response = {
      "SearchResult": {
       "Items": [
        {
         "ASIN": "1473619815",
         "DetailPageURL": "https://www.amazon.com.au/dp/1473619815?tag=booko01-22&linkCode=osi&th=1&psc=1",
         "Images": {
          "Primary": {
           "Large": {
            "Height": 500,
            "URL": "https://m.media-amazon.com/images/I/51HoUcxVnFL.jpg",
            "Width": 325
           }
          }
         },
         "ItemInfo": {
          "ByLineInfo": {
           "Contributors": [
            {
             "Locale": "en_AU",
             "Name": "Chambers, Becky",
             "Role": "Author"
            }
           ],
           "Manufacturer": {
            "DisplayValue": "Hodder Paperbacks",
            "Label": "Manufacturer",
            "Locale": "en_AU"
           }
          },
          "Classifications": {
           "Binding": {
            "DisplayValue": "Paperback",
            "Label": "Binding",
            "Locale": "en_AU"
           },
           "ProductGroup": {
            "DisplayValue": "Book",
            "Label": "ProductGroup",
            "Locale": "en_AU"
           }
          },
          "ContentInfo": {
           "Edition": {
            "DisplayValue": "1",
            "Label": "Edition",
            "Locale": "en_AU"
           },
           "Languages": {
            "DisplayValues": [
             {
              "DisplayValue": "English",
              "Type": "Published"
             },
             {
              "DisplayValue": "English",
              "Type": "Original Language"
             },
             {
              "DisplayValue": "English",
              "Type": "Unknown"
             }
            ],
            "Label": "Language",
            "Locale": "en_AU"
           },
           "PagesCount": {
            "DisplayValue": 432,
            "Label": "NumberOfPages",
            "Locale": "en_US"
           },
           "PublicationDate": {
            "DisplayValue": "2016-03-08T00:00:01Z",
            "Label": "PublicationDate",
            "Locale": "en_US"
           }
          },
          "ExternalIds": {
           "EANs": {
            "DisplayValues": [
             "9781473619814"
            ],
            "Label": "EAN",
            "Locale": "en_US"
           },
           "ISBNs": {
            "DisplayValues": [
             "1473619815"
            ],
            "Label": "ISBN",
            "Locale": "en_US"
           }
          },
          "ManufactureInfo": {
           "ItemPartNumber": {
            "DisplayValue": "23025256",
            "Label": "PartNumber",
            "Locale": "en_US"
           }
          },
          "ProductInfo": {
           "ItemDimensions": {
            "Weight": {
             "DisplayValue": 471,
             "Label": "Weight",
             "Locale": "en_AU",
             "Unit": "Grams"
            }
           },
           "ReleaseDate": {
            "DisplayValue": "2016-03-08T00:00:01Z",
            "Label": "ReleaseDate",
            "Locale": "en_US"
           },
           "UnitCount": {
            "DisplayValue": 1,
            "Label": "NumberOfItems",
            "Locale": "en_US"
           }
          },
          "Title": {
           "DisplayValue": "The Long Way to a Small, Angry Planet: Wayfarers 1",
           "Label": "Title",
           "Locale": "en_AU"
          }
         },
         "Offers": {
          "Listings": [
           {
            "Availability": {
             "MaxOrderQuantity": 20,
             "Message": "In stock.",
             "MinOrderQuantity": 1,
             "Type": "Now"
            },
            "Condition": {
             "SubCondition": {
              "Value": "New"
             },
             "Value": "New"
            },
            "DeliveryInfo": {
             "IsAmazonFulfilled": true,
             "IsFreeShippingEligible": true,
             "IsPrimeEligible": true
            },
            "Id": "1UP5v2BpBF5QeBZF7Dge7V%2BN3pdmW4ZkvT%2BvE4GABbmz4koGqDSZFDZwQj5o95bZrvKmWdqZPW0SiDhCIOjyAKlRmsz4hYXtSkQLSlwCc77AiiAbX1ja0CBjRVVdgLJ6",
            "IsBuyBoxWinner": true,
            "MerchantInfo": {
             "Id": "ANEGB3WVEVKZB",
             "Name": "Amazon AU"
            },
            "Price": {
             "Amount": 16.41,
             "Currency": "AUD",
             "DisplayAmount": "$16.41"
            },
            "ProgramEligibility": {
             "IsPrimeExclusive": false,
             "IsPrimePantry": false
            },
            "ViolatesMAP": false
           }
          ],
          "Summaries": [
           {
            "Condition": {
             "Value": "New"
            },
            "HighestPrice": {
             "Amount": 49.31,
             "Currency": "AUD",
             "DisplayAmount": "$49.31"
            },
            "LowestPrice": {
             "Amount": 15.46,
             "Currency": "AUD",
             "DisplayAmount": "$15.46"
            },
            "OfferCount": 18
           }
          ]
         }
        }
       ],
       "SearchURL": "https://www.amazon.com.au/s?k=9781473619814&rh=p_n_availability%3A-1&tag=booko01-22&linkCode=osi",
       "TotalResultCount": 1
      }
     }
  end
end
