require 'test_helper'

class PaapiTest < Minitest::Test
  def setup
    Paapi.configure do |config|
      config.access_key = nil
      config.secret_key = nil
      config.market = nil
      config.partner_tag = nil
      config.resources = nil
      config.partner_type = nil
    end
  end
  def test_that_it_has_a_version_number
    refute_nil ::Paapi::VERSION
  end

  def test_configuration_is_correctly_set_using_partner_market
    Paapi.configure do |config|
      config.access_key = 'some_key'
      config.secret_key = 'some_secret'
      config.partner_market = {au: 'au_partner', us: 'us_partner', uk: 'uk_partner', ca: 'ca_partner'}
    end

    c = Paapi::Client.new
    assert_equal :us, c.market, "Default Market should be US"
    assert_equal 'us_partner', c.partner_tag

    c = Paapi::Client.new(market: :au)
    assert_equal 'au_partner', c.partner_tag

    c.market = :ca
    assert_equal 'ca_partner', c.partner_tag

    # set the market to an unconfigured market, should not change the partner_tag
    orig_tag = c.partner_tag
    c.market = :gb
    assert_equal orig_tag, c.partner_tag

  end

  def test_configuration_is_correctly_set_using
    Paapi.configure do |config|
      config.access_key = 'some_key'
      config.secret_key = 'some_secret'
      config.partner_tag = 'abc'
      config.market = :uk
    end

    c = Paapi::Client.new

    assert_equal 'abc', c.partner_tag
    assert_equal :uk, c.market
    assert_equal 'some_key', c.access_key
  end

  def test_configuration_defaults_are_correct
    Paapi.configure do |config|
      config.access_key = 'some_key'
      config.secret_key = 'some_secret'
    end
    c = Paapi::Client.new
    assert_equal Paapi::DEFAULT_RESOURCES, c.resources

    resources = ['test1', 'test2']

    Paapi.configure do |config|
      config.access_key = 'some_key'
      config.secret_key = 'some_secret'
      config.resources = resources
    end
    c = Paapi::Client.new
    assert_equal resources, c.resources
  end

end
