# Paapi

`paapi` is a slim wrapper around [Amazon's Product Advertising API 5.0](https://webservices.amazon.com/paapi5/documentation/).

[![Build Status](https://travis-ci.org/dkam/paapi.svg?branch=master)](https://travis-ci.org/dkam/paapi)

If this gem doesn't meet your needs, try the [Vacuum gem](https://github.com/hakanensari/vacuum).

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

### Configuration

The library can be configured with an initializer. For Rails, create the file `config/initializers/paapi.rb`

```ruby
Paapi.configure do |config|
  config.access_key = 'your-access-key'
  config.secret_key = 'your-secret-key'
  config.partner_tag = 'your-tag'
end
```

Configurable items:
 * access_key
 * secret_key
 * partner_tag
 * partner_type
 * market
 * partner_market
 * test_mode

Using the `partner_market` configuration item lets you set a hash of marketplaces and partner_tags.

```ruby
Paapi.configure do |config|
  config.access_key = 'your-access-key'
  config.secret_key = 'your-secret-key'
  config.partner_market = {au: 'au_partner_tag', us: 'us_partner_tag'}
end

client = Paapi::Client.new(market: :au)

client.partner_tag
> 'au_partner_tag'

client.market = :us

client.partner_tag
> 'us_partner_tag'
```

The full list of market keys is `au, br, ca, fr, de, in, it, jp, mx, es, tr, ae, uk, us`

### Using Paapi

```ruby
require 'paapi'

client = Paapi::Client.new(access_key: ENV['access_key'], secret_key: ENV['secret_key'], market: :au, partner_tag: ENV['partner_tag'])

gi = client.get_items(item_ids: '1857231384')

si = client.search_items(keywords: 'Harry Potter')

gv = client.get_variations(asin: 'B00422MCUS')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

If you create a file `config.rb`, it will be loaded by `bin/console`, allowing you to configure keys and markets.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dkam/paapi.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
