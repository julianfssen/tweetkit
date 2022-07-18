require "test_helper"

class DummyResponse
  attr_accessor :body
end

class Tweetkit::ResponseTest < Minitest::Test
  def setup
    @response = DummyResponse.new
    @options = {}
  end

  def test_build_tweet_resource
    @options[:resource] = :tweet
    @response.body = { "data" => { "id" => "1", body: "test" } }

    assert_equal Tweetkit::Response::Tweet, Tweetkit::Response.build_resource(@response, **@options).class
  end

  def test_build_tweets_resource
    @response.body = { "data" => [{ "id" => "1", body: "test" }] }
    @options[:resource] = :tweets

    assert_equal Tweetkit::Response::Tweets, Tweetkit::Response.build_resource(@response, **@options).class
  end

  def test_build_successful_deleted_resource
    @response.body = { "data" => { "deleted" => true } }
    @options[:method] = :delete

    assert Tweetkit::Response.build_resource(@response, **@options)
  end

  def test_build_fail_deleted_resource
    @response.body = {}
    @options[:method] = :delete

    refute Tweetkit::Response.build_resource(@response, **@options)
  end
end
