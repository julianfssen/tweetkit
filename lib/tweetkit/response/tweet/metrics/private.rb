module Tweetkit
  class Response
    class Tweet
      # Non-public engagement metrics for the Tweet at the time of the request. 
      # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
      # To return this field, add +{ tweet_fields: "non_public_metrics" } or { fields: { tweet: "non_public_metrics" } }+ in the request's query parameter.
      class Metrics
        class Private
          attr_accessor :private_metrics

          def initialize(private_metrics)
            @private_metrics = private_metrics
          end

          # Number of times the Tweet has been viewed. 
          # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
          def impression_count
            private_metrics["impression_count"]
          end

          # @see impression_count
          def impressions
            impression_count
          end

          # Number of times a user clicks on a URL link or URL preview card in a Tweet. 
          # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
          def url_link_clicks
            private_metrics["url_link_clicks"]
          end

          # @see url_link_clicks
          def link_clicks
            url_link_clicks
          end

          # Number of times a user clicks on a URL link or URL preview card in a Tweet. 
          # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
          def user_profile_clicks
            private_metrics["user_profile_clicks"]
          end

          # @see user_profile_clicks
          def profile_clicks
            user_profile_clicks
          end
        end
      end
    end
  end
end
