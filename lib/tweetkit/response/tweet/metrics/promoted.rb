module Tweetkit
  class Response
    class Tweet
      class Metrics
        # Engagement metrics for the Tweet at the time of the request in a promoted context. 
        # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
        # To return this field, add +{ tweet_fields: "promoted_metrics" } or { fields: { tweet: "promoted_metrics" } }+ in the request's query parameter.
        class Promoted
          attr_accessor :promoted_metrics

          def initialize(promoted_metrics)
            @promoted_metrics = promoted_metrics
          end

          # Number of times the Tweet has been viewed when that Tweet is being promoted.
          # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
          #
          # @return [Integer]
          def impression_count
            promoted_metrics["impression_count"]
          end

          # Number of times a user clicks on a URL link or URL preview card in a Tweet when it is being promoted.
          # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
          #
          # @return [Integer]
          def url_link_clicks
            promoted_metrics["url_link_clicks"]
          end

          # Number of times a user clicks the following portions of a Tweet when it is being promoted - display name, user name, profile picture.
          # This is a private metric, and requires the use of OAuth 2.0 User Context authentication.
          #
          # @return [Integer]
          def user_profile_clicks
            promoted_metrics["user_profile_clicks"]
          end

          # Number of times this Tweet has been Retweeted when that Tweet is being promoted.
          #
          # @return [Integer]
          def retweet_count
            promoted_metrics["retweet_count"]
          end

          # Number of Replies to this Tweet when that Tweet is being promoted.
          #
          # @return [Integer]
          def reply_count
            promoted_metrics["reply_count"]
          end

          # Number of Likes of this Tweet when that Tweet is being promoted.
          #
          # @return [Integer]
          def like_count
            promoted_metrics["like_count"]
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
