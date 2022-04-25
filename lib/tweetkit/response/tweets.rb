module Tweetkit
  class Response
    # Class for a collection of Tweets
    class Tweets
      include Enumerable

      def initialize(response, **options)
        @tweets = extract_tweets(response)

        @meta = Meta.new(data["meta"])
        @expansions = Expansions.new(data["includes"])
      end

      def each(*args, &block)
        @tweets.each(*args, &block)
      end

      def last
        @tweets.last
      end

      private

      def extract_tweets(response)
        data = response["data"]

        if data.kind_of? Array
          data.collect { |data| Tweet.new(data) }
        else
          [Tweet.new(data)]
        end
      end
    end
  end
end
