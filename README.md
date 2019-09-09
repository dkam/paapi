# Paapi

`paapi` is a slim wrapper around [Amazon's Product Advertising API 5.0](https://webservices.amazon.com/paapi5/documentation/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'paapi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install paapi

## Usage

```ruby
require 'paapi'

client = Paapi::Client.new(access_key: ENV['access_key'], secret_key: ENV['secret_key'], marketplace: :au, partner_tag: ENV['partner_tag'])

gi = client.get_items(item_ids: '1857231384')

si = client.search_items(keywords: 'Harry Potter')

gv = client.get_variations(asin: 'B00422MCUS')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dkam/paapi.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
