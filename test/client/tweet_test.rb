require "test_helper"

class Tweetkit::Client::TweetTest < Minitest::Test
  attr_accessor :client

  TWEET_ID = 1212092628029698048
  GEO_TWEET_ID = 1136048014974423040
  POLL_TWEET_ID = 1199786642791452673

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

  def test_created_at
    assert @tweet.created_at
  end

  def test_author_id
    assert @tweet.author_id
  end

  def test_author
    assert_equal @tweet.author.id, @tweet.author_id
  end

  def test_conversation_id
    assert @tweet.conversation_id
  end

  def test_conversation
    assert_equal @tweet.conversation.conversation_id, @tweet.conversation_id
  end

  def test_in_reply_to_user_id
    assert @tweet.in_reply_to_user_id
  end

  def test_reply_to
    assert_equal @tweet.reply_to.id, @tweet.in_reply_to_user_id
  end

  def test_referenced_tweets
    assert @tweet.referenced_tweets
  end

  def test_attachments
    assert @tweet.attachments
  end

  def test_polls
    @tweet = @client.tweet(POLL_TWEET_ID, all_public_fields_and_expansions: true)
    assert @tweet.polls
  end

  def test_geo
    @tweet = @client.tweet(GEO_TWEET_ID, all_public_fields_and_expansions: true)
    assert @tweet.geo
  end

  def test_context_annotations
    assert @tweet.context_annotations
  end

  def test_entity_annotations
    assert @tweet.entity_annotations
  end

  def test_withheld?
    refute @tweet.withheld?
  end

  def test_withheld
    refute @tweet.withheld
  end

  def test_metrics
    assert @tweet.metrics
  end

  def test_public_metrics
    assert @tweet.public_metrics
  end

  def test_private_metrics
    assert @tweet.private_metrics
  end

  def test_organic_metrics
    assert @tweet.organic_metrics
  end

  def test_promoted_metrics
    assert @tweet.promoted_metrics
  end

  def test_possibly_sensitive
    refute @tweet.possibly_sensitive
  end

  def test_lang
    assert @tweet.lang
  end

  def test_reply_settings
    assert @tweet.reply_settings
  end

  def test_source
    assert @tweet.source
  end

  def test_url
    assert @tweet.url
  end

  # Aliased methods

  def test_body
    assert_equal @tweet.body, @tweet.text
  end

  def test_content
    assert_equal @tweet.content, @tweet.text
  end

  def test_device
    assert_equal @tweet.device, @tweet.source
  end

  def test_date
    assert_equal @tweet.date, @tweet.created_at
  end

  def test_parent_tweet_id
    assert_equal @tweet.parent_tweet_id, @tweet.conversation_id
  end

  def test_nsfw?
    assert_equal @tweet.nsfw?, @tweet.possibly_sensitive
  end

  def test_sensitive?
    assert_equal @tweet.sensitive?, @tweet.possibly_sensitive
  end

  def test_non_public_metrics
    assert_equal @tweet.non_public_metrics, @tweet.private_metrics
  end

  def test_language
    assert_equal @tweet.language, @tweet.lang
  end
end
