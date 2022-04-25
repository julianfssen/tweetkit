module Tweetkit
  class Response
    class Tweet
      class Metrics
        attr_accessor :public_metrics

        def initialize(**metrics)
          return unless metrics

          @public_metrics = Public.new(metrics[:public_metrics])
        end

        class Public
          attr_accessor :like_count, :quote_count, :reply_count, :retweet_count

          def initialize(public_metric)
            @like_count = public_metric["like_count"]
            @quote_count = public_metric["quote_count"]
            @reply_count = public_metric["reply_count"]
            @retweet_count = public_metric["retweet_count"]
          end

          def likes
            @like_count
          end

          def quotes
            @quote_count
          end

          def replies
            @reply_count
          end

          def retweets
            @retweet_count
          end
        end
      end
    end
  end
end
