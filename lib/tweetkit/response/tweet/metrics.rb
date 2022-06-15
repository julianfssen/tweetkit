module Tweetkit
  class Response
    class Tweet
      # Public, private, promoted, and organic metrics for the Tweet at the time of the request.
      #
      # @see https://developer.twitter.com/en/docs/twitter-api/metrics
      class Metrics
        attr_accessor :metrics

        # @return [Tweetkit::Response::Tweet::Metrics::Public]
        def initialize(**metrics)
          return unless metrics

          @metrics = metrics
        end

        # @return [Tweetkit::Response::Tweet::Metrics::Public]
        def public_metrics
          @public_metrics ||= Public.new(metrics[:public_metrics])
        end

        # @return [Tweetkit::Response::Tweet::Metrics::Private]
        def private_metrics
          @private_metrics ||= Private.new(metrics[:private_metrics])
        end

        # @return [Tweetkit::Response::Tweet::Metrics::Organic]
        def organic_metrics
          @organic_metrics ||= Organic.new(metrics[:organic_metrics])
        end

        # @return [Tweetkit::Response::Tweet::Metrics::Promoted]
        def promoted_metrics
          @promoted_metrics ||= Promoted.new(metrics[:promoted_metrics])
        end
      end
    end
  end
end
