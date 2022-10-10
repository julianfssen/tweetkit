require "test_helper"

class Tweetkit::AuthTest < Minitest::Test
  def test_token_auth?
    client = Tweetkit::Client.new(
      access_token: ENV["ACCESS_TOKEN"], 
      access_token_secret: ENV["ACCESS_TOKEN_SECRET"],
      consumer_key: ENV["CONSUMER_KEY"],
      consumer_secret: ENV["CONSUMER_SECRET"]
    )

    assert client.token_auth?
    refute client.bearer_auth?
  end

  def test_bearer_auth?
    client = Tweetkit::Client.new(
      bearer_token: ENV["BEARER_TOKEN"], 
    )

    refute client.token_auth?
    assert client.bearer_auth?
  end
end
