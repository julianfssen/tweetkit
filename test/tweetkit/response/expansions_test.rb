require "test_helper"

class Tweetkit::Response::ExpansionsTest < Minitest::Test
  attr_accessor :client

  TWEET_ID = 1212092628029698048
  GEO_TWEET_ID = 1136048014974423040
  POLL_TWEET_ID = 1199786642791452673

  def setup
    @client = Tweetkit::Client.new(bearer_token: ENV["BEARER_TOKEN"])
  end

  def test_media
    @tweet = @client.tweet(TWEET_ID, all_public_fields_and_expansions: true)

    assert @tweet.expansions.media
  end

  def test_places
    @tweet = @client.tweet(GEO_TWEET_ID, all_public_fields_and_expansions: true)

    assert @tweet.expansions.places
  end

  def test_polls
    @tweet = @client.tweet(POLL_TWEET_ID, all_public_fields_and_expansions: true)

    assert @tweet.expansions.polls
  end

  def test_tweets
    @tweet = @client.tweet(TWEET_ID, all_public_fields_and_expansions: true)

    assert @tweet.expansions.tweets
  end

  def test_users
    @tweet = @client.tweet(TWEET_ID, all_public_fields_and_expansions: true)

    assert @tweet.expansions.users
  end
end
