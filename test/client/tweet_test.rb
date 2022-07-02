require "test_helper"

# TODO: Add tests for individual Tweet class
class Tweetkit::Client::TweetTest < Minitest::Test
  attr_accessor :client

  TWEET_ID = 1212092628029698048

  def setup
    @client = Tweetkit::Client.new(bearer_token: ENV["BEARER_TOKEN"])
    @tweet = @client.tweet(TWEET_ID, all_public_fields_and_expansions: true)
  end

  def test_id
    assert @tweet.id
  end

  def test_text
    assert @tweet.text
  end
end
