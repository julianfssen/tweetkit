require "test_helper"

class Tweetkit::Response::TweetsTest < Minitest::Test
  TWEET_ID = 1212092628029698048
  GEO_TWEET_ID = 1136048014974423040
  POLL_TWEET_ID = 1199786642791452673

  def setup
    @client = Tweetkit::Client.new(bearer_token: ENV["BEARER_TOKEN"])
    @tweets = @client.tweets([TWEET_ID, GEO_TWEET_ID, POLL_TWEET_ID], all_public_fields_and_expansions: true)
  end

  # def test_tweets
  #   assert_equal Tweetkit::Response::Tweets, @tweets.class
  # end

  def test_meta
    @tweets = @client.search("twitter")
    assert_equal Tweetkit::Response::Tweets::Meta, @tweets.meta.class
  end

  # def test_last
  #   assert_equal Tweetkit::Response::Tweet, @tweets.last.class
  # end

  # def test_array_accessor
  #   assert_equal Tweetkit::Response::Tweet, @tweets[0].class
  # end
end
