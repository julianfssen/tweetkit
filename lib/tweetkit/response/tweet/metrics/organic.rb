module Tweetkit
  class Response
    class Tweet
      class Metrics
        # Organic engagement metrics for the Tweet at the time of the request. 
        # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
        # To return this field, add +{ tweet_fields: "organic_metrics" } or { fields: { tweet: "organic_metrics" } }+ in the request's query parameter.
        class Organic
          attr_accessor :organic_metrics

          def initialize(organic_metrics)
            @organic_metrics = organic_metrics
          end

          # Number of times the Tweet has been viewed organically.
          # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
          #
          # @return [Integer]
          def impression_count
            organic_metrics["impression_count"]
          end

          # Number of times a user clicks on a URL link or URL preview card in a Tweet organically.
          # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
          #
          # @return [Integer]
          def url_link_clicks
            organic_metrics["url_link_clicks"]
          end

          # Number of times a user clicks the following portions of a Tweet organically - display name, user name, profile picture.
          # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
          #
          # @return [Integer]
          def user_profile_clicks
            organic_metrics["user_profile_clicks"]
          end

          # Number of times the Tweet has been Retweeted organically.
          #
          # @return [Integer]
          def retweet_count
            organic_metrics["retweet_count"]
          end

          # Number of replies the Tweet has received organically.
          #
          # @return [Integer]
          def reply_count
            organic_metrics["reply_count"]
          end

          # Number of likes the Tweet has received organically.
          #
          # @return [Integer]
          def like_count
            organic_metrics["like_count"]
          end

          alias_method :impressions, :impression_count
          alias_method :link_clicks, :url_link_clicks
          alias_method :profile_clicks, :user_profile_clicks
          alias_method :retweets, :retweet_count
          alias_method :replies, :reply_count
          alias_method :likes, :like_count
        end
      end
    end
  end
end
