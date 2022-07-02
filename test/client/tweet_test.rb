require "test_helper"

# TODO: Add tests for individual Tweet class
class Tweetkit::Client::TweetTest < Minitest::Test
  attr_accessor :client

  def setup
    @client = Tweetkit::Client.new(bearer_token: ENV["BEARER_TOKEN"])
  end
end
