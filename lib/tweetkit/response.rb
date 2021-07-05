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
      include Enumerable

      attr_accessor :tweets

      def initialize(tweets)
        tweets = tweets.collect { |tweet| Tweetkit::Response::Tweet.new(tweet) }
        @tweets = Array.new(tweets)
      end

      def each(*args, &block)
        tweets.each(*args, &block)
      end

      def last
        tweets.last
      end

      def to_s
        @tweets.join(' ')
      end
    end

    class Tweet
      attr_accessor :tweet

      def initialize(tweet)
        @tweet = tweet
      end

      def method_missing(attribute)
        data = tweet[attribute.to_s]
        super if data.empty?
      end

      def respond_to_missing?
        tweet[attribute.to_s].any?
      end
    end
  end
end
