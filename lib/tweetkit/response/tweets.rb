module Tweetkit
  module Response
    class Tweets
      include Enumerable

      attr_accessor :annotations,
                    :connection,
                    :context_annotations,
                    :entity_annotations,
                    :expansions,
                    :fields,
                    :meta,
                    :options,
                    :tweets,
                    :twitter_request

      def initialize(data, **options)
        @tweets = extract_tweets(data)
        return if @tweets.nil?

        @meta = Meta.new(data["meta"])
        @expansions = Expansions.new(data["includes"])
        @connection = options[:connection]
        @request = options[:request]
      end

      def extract_tweets(data)
        data = data["data"]
        return if data.nil? || data.empty?

        data.collect { |tweet| Tweet.new(tweet) }
      end

      def each(*args, &block)
        tweets.each(*args, &block)
      end

      def last
        tweets.last
      end
    end
  end
end
