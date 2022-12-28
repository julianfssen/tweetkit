require "test_helper"

class Tweetkit::Response::Expansions::MediaObjectTest < Minitest::Test
  attr_accessor :client

  TWEET_ID = 1212092628029698048

  def setup
    @client = Tweetkit::Client.new(bearer_token: ENV["BEARER_TOKEN"])
    @tweet = @client.tweet(TWEET_ID, all_public_fields_and_expansions: true)
    @media_object = @tweet.expansions.media.first
  end

  def test_media_key
    assert @media_object.media_key
  end

  def test_type
    assert @media_object.type
  end

  def test_url
    assert @media_object.url
  end

  def test_duration_ms
    assert @media_object.duration_ms
  end

  def test_height
    assert @media_object.height
  end

  def test_non_public_metrics
    assert @media_object.non_public_metrics
  end

  def test_organic_metrics
    assert @media_object.organic_metrics
  end

  def test_promoted_metrics
    assert @media_object.promoted_metrics
  end

  def test_public_metrics
    assert @media_object.public_metrics
  end

  def test_preview_image_url
    assert @media_object.preview_image_url
  end

  def test_width
    assert @media_object.width
  end

  def test_alt_text
    assert @media_object.alt_text
  end

  def test_variants
    assert @media_object.variants
  end
end
