module Tweetkit
  class Response
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
                    :tweets

      def initialize(response, **options)
        @tweets = extract_tweets(response)

        # TODO: Check tweet meta expansions and annotations
        # @meta = Meta.new(data["meta"])
        # @expansions = Expansions.new(data["includes"])
      end

      def each(*args, &block)
        tweets.each(*args, &block)
      end

      def last
        tweets.last
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
