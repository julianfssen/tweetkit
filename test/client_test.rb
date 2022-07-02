require "test_helper"

class ClientTest < Minitest::Test
  def test_new_client
    client = Tweetkit::Client.new(
      access_token: ENV["ACCESS_TOKEN"], 
      access_token_secret: ENV["ACCESS_TOKEN_SECRET"],
      bearer_token: ENV["BEARER_TOKEN"],
      consumer_key: ENV["CONSUMER_KEY"],
      consumer_secret: ENV["CONSUMER_SECRET"]
    )

    assert_equal ENV["ACCESS_TOKEN"], client.access_token
    assert_equal ENV["ACCESS_TOKEN_SECRET"], client.access_token_secret
    assert_equal ENV["BEARER_TOKEN"], client.bearer_token
    assert_equal ENV["CONSUMER_KEY"], client.consumer_key
    assert_equal ENV["CONSUMER_SECRET"], client.consumer_secret
  end
end
