module Tweetkit
  class Response
    # Class for a collection of Tweets
    class Tweets
      attr_accessor :response

      include Enumerable

      def initialize(response, **options)
        @response = response
        @tweets = extract_tweets(response["data"])
      end

      def each(*args, &block)
        @tweets.each(*args, &block)
      end

      def last
        @tweets.last
      end

      # Returns the Tweets fetched from the given IDs
      #
      # @return [Tweetkit::Response::Tweets] Collection of Tweets fetched
      def tweets
        @tweets
      end

      # Returns the metadata required for pagination and other query-related operations
      #
      # @return [Tweetkit::Response::Tweets::Meta] Tweets metadata
      def meta
        @meta ||= Meta.new(response["meta"])
      end

      # Returns the expansions data based off the expansions passed in the initial query
      #
      # @return [Tweetkit::Response::Tweets::Expansions] Expansions data
      def expansions
        @expansions ||= Expansions.new(response["includes"])
      end

      private

      def extract_tweets(data)
        if data.kind_of? Array
          data.collect { |data| Tweet.new(data) }
        else
          [Tweet.new(data)]
        end
      end
    end
  end
end
