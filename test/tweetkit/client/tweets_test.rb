require "test_helper"

class Tweetkit::Client::TweetsTest < Minitest::Test
  TEST_TWEET_ID_1 = 1228393702244134912
  TEST_TWEET_ID_2 = 1227640996038684673

  def setup
    client_types = {
      bearer_token: Tweetkit::Client.new(bearer_token: ENV["BEARER_TOKEN"]),
      access_token: Tweetkit::Client.new(
        consumer_key: ENV["CONSUMER_KEY"],
        consumer_secret: ENV["CONSUMER_SECRET"],
        access_token: ENV["ACCESS_TOKEN"],
        access_token_secret: ENV["ACCESS_TOKEN_SECRET"],
      )
    }

    @bearer_token_client = client_types[:bearer_token]
    @access_token_client = client_types[:access_token]
  end

  def test_tweet
    tweet = @bearer_token_client.tweet(TEST_TWEET_ID_1)

    assert tweet.text
  end

  def test_tweets_from_array_of_ids
    tweets = @bearer_token_client.tweets([TEST_TWEET_ID_1, TEST_TWEET_ID_2])

    assert_equal 2, tweets.count
  end

  def test_tweets_from_string_of_ids
    tweets = @bearer_token_client.tweets("#{TEST_TWEET_ID_1}, #{TEST_TWEET_ID_2}")

    assert_equal 2, tweets.count
  end

  def test_tweet_fails_with_invalid_id_args
    assert_raises(Tweetkit::Error::ClientError) do
      @bearer_token_client.tweet("fail")
    end
  end

  def test_tweet_fails_with_invalid_options
    assert_raises(Tweetkit::Error::ClientError) do
      @bearer_token_client.tweet(TEST_TWEET_ID_1, fail: true)
    end
  end

  def test_tweets_fails_with_invalid_id_args
    assert_raises(Tweetkit::Error::ClientError) do
      @bearer_token_client.tweets("fail")
    end

    assert_raises(Tweetkit::Error::ClientError) do
      @bearer_token_client.tweets(["fail"])
    end
  end

  def test_tweets_fails_with_invalid_options
    assert_raises(Tweetkit::Error::ClientError) do
      @bearer_token_client.tweets([TEST_TWEET_ID_1], fail: true)
    end
  end

  def test_post_tweet
    text = random_text
    tweet = @access_token_client.post_tweet(text: text)

    assert_equal text, tweet.text
  end

  def test_post_tweet_fails_with_invalid_options
    text = random_text

    assert_raises(Tweetkit::Error::ClientError) do
      @access_token_client.post_tweet(text: text, fail: true)
    end
  end

  def test_delete_tweet
    text = random_text
    tweet = @access_token_client.post_tweet(text: text)
    tweet_id = tweet.id.to_i
    deleted = @access_token_client.delete_tweet(tweet_id)

    assert_equal true, deleted
  end

  def test_delete_tweet_fails_for_other_users_tweets
    assert_raises(Tweetkit::Error::ClientError) do
      @access_token_client.delete_tweet(TEST_TWEET_ID_1)
    end
  end

  private

  def random_text
    random_string = rand(36 ** 8).to_s(36)

    "Hi! This is a random string to test the Tweetkit gem: #{random_string}"
  end
end
