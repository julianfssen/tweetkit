require 'json'

module Tweetkit
  class Response
    attr_accessor :body, :tweets, :meta

    def initialize(response)
      @json_body = response.body
      @body = JSON.parse(@json_body)
      @tweets = Tweetkit::Response::Tweets.new(@body['data'])
      @meta = @body['meta']
    end

    class Tweets
      attr_accessor :tweets

      def initialize(tweets)
        @tweets = tweets.collect { |tweet| Tweetkit::Response::Tweet.new(tweet) }
      end
    end

    class Tweet
      attr_accessor :tweet

      def initialize(tweet)
        @tweet = tweet
      end

      def method_missing(attribute)
        tweet[attribute.to_s]
      end

      def respond_to_missing?
        tweet[attribute.to_s].any?
      end
    end
  end
end
