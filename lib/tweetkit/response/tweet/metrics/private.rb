module Tweetkit
  class Response
    class Tweet
      class Metrics
        # Private engagement metrics for the Tweet at the time of the request. 
        # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
        # To return this field, add +{ tweet_fields: "non_public_metrics" } or { fields: { tweet: "non_public_metrics" } }+ in the request's query parameter.
        class Private
          attr_accessor :private_metrics

          def initialize(private_metrics)
            @private_metrics = private_metrics
          end

          # Number of times the Tweet has been viewed. 
          # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
          #
          # @return [Integer]
          def impression_count
            private_metrics["impression_count"]
          end

          # Number of times a user clicks on a URL link or URL preview card in a Tweet. 
          # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
          #
          # @return [Integer]
          def url_link_clicks
            private_metrics["url_link_clicks"]
          end

          # Number of times a user clicks on a URL link or URL preview card in a Tweet. 
          # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
          #
          # @return [Integer]
          def user_profile_clicks
            private_metrics["user_profile_clicks"]
          end

          alias_method :impressions, :impression_count
          alias_method :link_clicks, :url_link_clicks
          alias_method :profile_clicks, :user_profile_clicks
        end
      end
    end
  end
end
