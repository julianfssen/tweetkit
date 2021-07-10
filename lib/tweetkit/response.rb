require 'json'
require 'pry'

module Tweetkit
  class Response
    attr_accessor :expansions, :meta, :original_response, :tweets

    def initialize(response)
      @original_response = response.body
      parsed_response = JSON.parse(@original_response)
      @tweets = Tweetkit::Response::Tweets.new(parsed_response)
      @meta = Tweetkit::Response::Meta.new(@tweets.meta)
      @expansions = Tweetkit::Response::Expansions.new(@tweets.expansions)
    end

    class Expansions
      include Enumerable

      attr_accessor :expansions

      def initialize(expansions)
        @expansions = expansions
      end

      def method_missing(attribute, **args)
        data = expansions[attribute.to_s]
        data.empty? ? super : data
      end

      def respond_to_missing?(method)
        expansions.respond_to? method
      end
    end

    class Meta
      include Enumerable

      attr_accessor :meta

      def initialize(meta)
        @meta = meta
      end

      def method_missing(attribute, **args)
        data = meta[attribute.to_s]
        data.empty? ? super : data
      end

      def respond_to_missing?(method)
        meta.respond_to? method
      end
    end

    class Tweets
      include Enumerable

      attr_accessor :tweets, :meta, :expansions

      def initialize(response)
        @tweets = response['data'].collect { |tweet| Tweetkit::Response::Tweet.new(tweet) }
        @meta = response['meta']
        @expansions = response['includes']
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

      def method_missing(attribute, **args)
        result = tweets.public_send(attribute, **args)
        super unless result
      rescue StandardError
        super
      end

      def respond_to_missing?(method)
        tweets.respond_to? method
      end
    end

    class Tweet
      attr_accessor :tweet

      def initialize(tweet)
        @tweet = tweet
      end

      def method_missing(attribute)
        data = tweet[attribute.to_s]
        data.empty? ? super : data
      end

      def respond_to_missing?(method)
        tweet.respond_to? method
      end
    end
  end
end
