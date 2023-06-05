## 0.1.9 (Unreleased)
- Fix bug allowing non-title case Request Parameters
- Add the required PartnerTag and PartnerType key values to the search body request

## 0.1.7
- Add gem 'net-http-persistent' for connection persistance
- Remove the code which would use other http clients if available
## 0.1.3
- Dropped the HTTP gem and moved to Ruby's Net::HTTP
- Merged a branch which adds the Condtion parameter.

## 0.1.2
- Use Contributor RoleType, rather than Role.  RoleType uses lowercase, rather than capitalised. 

## 0.1.0
- Remove Nameable dependancy and return the data as the API returns it.

## 0.0.9
- Fix bug with no contributors in response

## 0.0.8
- Fix a bug when accessing an empty name via Item

## 0.0.7
- Rename Item#json to Item#hash for consistency
- Add offer / listing parsing

## 0.0.6
- Handle more date parsing failures. 
- Get width, height, depth and weight from items

## 0.0.5

- Merged pull request #3 allowing options to be passed into the get_items and get_variations request
- Merged #4 a bug fix for image_url
- Added test cases for parsing response

