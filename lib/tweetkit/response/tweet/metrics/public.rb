module Tweetkit
  class Response
    class Tweet
      class Metrics
        # Public engagement metrics for the Tweet at the time of the request.
        # To return this field, add +{ tweet_fields: "public_metrics" } or { fields: { tweet: "public_metrics" } }+ in the request's query parameter.
        class Public
          attr_accessor :public_metrics

          alias_method :likes, :like_count
          alias_method :quotes, :quote_count
          alias_method :replies, :reply_count
          alias_method :retweets, :retweet_count

          def initialize(public_metrics)
            @public_metrics = public_metrics
          end

          # Number of Likes of this Tweet.
          #
          # @return [Integer]
          def like_count
            public_metrics["like_count"]
          end

          # Number of times this Tweet has been Retweeted with a comment (also known as Quote).
          #
          # @return [Integer]
          def quote_count
            public_metrics["quote_count"]
          end

          # Number of Replies of this Tweet.
          #
          # @return [Integer]
          def reply_count
            public_metrics["reply_count"]
          end

          # Number of times this Tweet has been Retweeted.
          #
          # @return [Integer]
          def retweet_count
            public_metrics["retweet_count"]
          end
        end
      end
    end
  end
end
