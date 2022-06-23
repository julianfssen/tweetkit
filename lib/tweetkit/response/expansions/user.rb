module Tweetkit
  class Response
    class Expansions
      # Class for user data in a Tweet's expansion
      class User
        attr_accessor :user
      
        def initialize(user)
          @user = user
        end

        # Unique identifier of this user.
        #
        # @return [String]
        def id
          user["id"]
        end

        # The name of the user, as they’ve defined it on their profile. 
        # Not necessarily a person’s name. Typically capped at 50 characters, but subject to change.
        #
        # @return [String]
        def name
          user["name"]
        end

        # The Twitter screen name, handle, or alias that this user identifies themselves with. 
        # Usernames are unique but subject to change. 
        # Typically a maximum of 15 characters long, but some historical accounts may exist with longer names.
        #
        # @return [String]
        def username
          user["username"]
        end

        # The UTC (ISO8601) datetime that the user account was created on Twitter.
        #
        # @return [String]
        def created_at
          user["created_at"]
        end

        # The text of this user's profile description (also known as bio), if the user provided one.
        #
        # @return [String]
        def description
          user["description"]
        end

        # Contains details about text that has a special meaning in the user's description.
        #
        # TODO: Use Entities class
        def entities
        end

        # The location specified in the user's profile, if the user provided one. 
        # As this is a freeform value, it may not indicate a valid location, 
        # but it may be fuzzily evaluated when performing searches with location queries.
        #
        # @return [String]
        def location
          user["location"]
        end

        # Unique identifier of this user's pinned Tweet.
        #
        # @return [String]
        def pinned_tweet_id
          user["pinned_tweet_id"]
        end

        # The URL to the profile image for this user, as shown on the user's profile.
        #
        # @return [String]
        def profile_image_url
          user["profile_image_url"]
        end

        # Indicates if this user has chosen to protect their Tweets (in other words, if this user's Tweets are private).
        #
        # @return [Boolean]
        def protected
          user["protected"]
        end

        # Contains public details about activity for this user.
        # Can potentially be used to determine a Twitter user’s reach or influence, 
        # quantify the user’s range of interests, and the user’s level of engagement on Twitter.
        #
        # @return [Hash]
        def public_metrics
          user["public_metrics"]
        end

        # A URL provided by a Twitter user in their profile, if present.
        #
        # @return [String]
        def url
          user["url"]
        end

        # Indicates if this user is a verified Twitter User.
        #
        # @return [Boolean]
        def verified
          user["verified"]
        end

        # Contains withholding details for withheld content, if applicable.
        #
        # @see https://help.twitter.com/en/rules-and-policies/tweet-withheld-by-country
        #
        # @return [Hash]
        def withheld
          user["withheld"]
        end

        alias_method :private?, :protected
        alias_method :protected?, :protected
        alias_method :verified?, :verified
      end
    end
  end
end
