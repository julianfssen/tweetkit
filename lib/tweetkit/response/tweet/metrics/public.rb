module Tweetkit
  class Response
    class Tweet
      # Public engagement metrics for the Tweet at the time of the request.
      # To return this field, add +{ tweet_fields: "public_metrics" } or { fields: { tweet: "public_metrics" } }+ in the request's query parameter.
      class Metrics
        class Public
          attr_accessor :public_metrics

          def initialize(public_metrics)
            @public_metrics = public_metrics
          end

          # Number of Likes of this Tweet.
          def like_count
            public_metrics["like_count"]
          end

          # @see like_count
          def likes
            like_count
          end

          # Number of times this Tweet has been Retweeted with a comment (also known as Quote).
          def quote_count
            public_metrics["quote_count"]
          end

          # @see quote_count
          def quotes
            quote_count
          end

          # Number of Replies of this Tweet.
          def reply_count
            public_metrics["reply_count"]
          end

          # @see reply_count
          def replies
            reply_count
          end

          # Number of times this Tweet has been Retweeted.
          def retweet_count
            public_metrics["retweet_count"]
          end

          # @see retweet_count
          def retweets
            retweet_count
          end
        end
      end
    end
  end
end
