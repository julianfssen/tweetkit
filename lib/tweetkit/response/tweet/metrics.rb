module Tweetkit
  class Response
    class Tweet
      class Metrics
        attr_accessor :metrics

        def initialize(**metrics)
          return unless metrics

          @metrics = metrics
        end

        # @see Public
        def public_metrics
          @public_metrics ||= Public.new(metrics[:public_metrics])
        end

        # @see Private
        def private_metrics
          @private_metrics ||= Private.new(metrics[:private_metrics])
        end

        # @see Organic
        def organic_metrics
          @organic_metrics ||= Organic.new(metrics[:organic_metrics])
        end

        # @see Promoted
        def promoted_metrics
          @promoted_metrics ||= Promoted.new(metrics[:promoted_metrics])
        end
      end
    end
  end
end
