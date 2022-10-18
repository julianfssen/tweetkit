require "test_helper"

class Tweetkit::Response::Tweet::ContextAnnotationsTest < Minitest::Test
  TWEET_ID = 1212092628029698048
  GEO_TWEET_ID = 1136048014974423040
  POLL_TWEET_ID = 1199786642791452673

  def setup
    @client = Tweetkit::Client.new(bearer_token: ENV["BEARER_TOKEN"])
    @tweet = @client.tweet(TWEET_ID, tweet_fields: "context_annotations")
    @context_annotations = @tweet.context_annotations
    @context_annotation = @tweet.context_annotations.first
  end

  def test_domain
    assert @context_annotation.domain
  end

  def test_domain_id
    assert @context_annotation.domain_id
  end

  def test_domain_name
    assert @context_annotation.domain_name
  end

  def test_domain_description
    assert @context_annotation.domain_description
  end

  def test_entity
    assert @context_annotation.entity
  end

  def test_entity_id
    assert @context_annotation.entity_id
  end

  def test_entity_name
    assert @context_annotation.entity_name
  end

  # TODO: Fix this ugly test by changing response to be like Stripe objects (i.e. calling entity.description instead of entity_description)
  def test_entity_description
    @context_annotations.each do |context_annotation|
      if @context_annotation.entity_description
        assert(@context_annotation.entity_description)
        return
      end
    end
  end
end
