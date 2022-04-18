module Tweetkit::Response::Tweets::Expansions
  class Tweets
    attr_accessor :tweets
  
    def initialize(tweets)
      return unless tweets
  
      @tweets = tweets.collect { |tweet| Tweet.new(tweet) }
    end
  end
end
