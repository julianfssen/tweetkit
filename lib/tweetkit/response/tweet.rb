module Tweetkit
  class Response
    # Class for individual Tweets
    class Tweet
      attr_accessor :data, :expansions

      def initialize(data, expansions: nil)
        if data["data"].nil?
          @data = data
        else
          @data = data["data"]
        end

        unless data["includes"].nil? && expansions.nil?
          unless data["includes"].nil?
            @expansions = Expansions.new(data["includes"])
          else
            @expansions = Expansions.new(expansions)
          end
        end
      end

      # Unique ID for this Tweet
      # 
      # @return [String] Unique ID for this Tweet
      def id
        data["id"]
      end

      # The content of the Tweet
      # 
      # @return [String] The content of the Tweet
      def text
        data["text"]
      end

      # The time (ISO 8601) the Tweet was created
      # 
      # @note The field +tweet_fields: "created_at"+ option must be passed when fetching the tweet to access this data
      #
      # @return [String] The time (ISO 8601) the Tweet was created 
      # @return [nil] If +tweet_fields: "created_at"+ is not passed as an option when fetching the Tweet
      def created_at
        data["created_at"]
      end

      # Unique identifier of this user
      # 
      # @note The field +tweet_fields: "author_id"+ option must be passed when fetching the tweet to access this data
      #
      # @return [String] Unique identifier of this user
      # @return [nil] If +tweet_fields: "author_id"+ is not passed as an option when fetching the Tweet
      def author_id
        data["author_id"]
      end

      # +User+ object for the Tweet author
      # 
      # @note The expansion +expansions: "author_id"+ option must be passed when fetching the tweet to access this data
      #
      # @return [Tweetkit::Response::Expansions::User] +User+ object from {#author_id}
      # @return [nil] If the +User+ expansion (see {Tweetkit::Response::Expansions}) is empty or if {#author_id} returns +nil+
      def author
        expansions&.users.find { |user| user.id == author_id }
      end

      # Returns the origin / root Tweet ID of the conversation (which includes direct replies, replies of replies)
      # 
      # @note The field +tweet_fields: "conversation_id"+ option must be passed when fetching the tweet to access this data
      #
      # @return [String] Returns the origin / root Tweet ID of the conversation
      # @return [nil] If +tweet_fields: "conversation_id"+ is not passed as an option when fetching the Tweet
      def conversation_id
        data["conversation_id"]
      end

      # Returns the origin / root Tweet object of the conversation (which includes direct replies, replies of replies)
      # 
      # @note The expansion +expansions: "referenced_tweets.id"+ option must be passed when fetching the tweet to access this data
      #
      # @return [Tweetkit::Response::Tweet] +Tweet+ object from {#conversation_id}
      # @return [nil] If the +Tweet+ expansion (see {Tweetkit::Response::Expansions}) is empty or if {#conversation_id} returns +nil+
      def conversation
        expansions&.tweets.find { |tweet| tweet.conversation_id == conversation_id }
      end

      # If this Tweet is a reply, returns the user ID of the parent tweet's author
      # 
      # @note The field +tweet_fields: "in_reply_to_user_id"+ option must be passed when fetching the tweet to access this data
      #
      # @return [String] If this Tweet is a Reply, indicates the user ID of the parent Tweet's author.
      # @return [nil] If +tweet_fields: "in_reply_to_user_id"+ is not passed as an option when fetching the Tweet
      def in_reply_to_user_id
        data["in_reply_to_user_id"]
      end

      # Returns the user object from the ID of the parent tweet's author
      # 
      # @note The expansion +expansions: "in_reply_to_user_id"+ option must be passed when fetching the tweet to access this data
      #
      # @return [Tweetkit::Response::Expansions::User] +User+ object from {#in_reply_to_user_id}
      # @return [nil] If the +User+ expansion (see {Tweetkit::Response::Expansions}) is empty or if {#in_reply_to_user_id} returns +nil+
      def reply_to
        expansions&.users.find { |user| user.id == in_reply_to_user_id }
      end

      # A list of Tweets this Tweet refers to. For example, if the parent Tweet is a Retweet, a Retweet with comment (also known as Quoted Tweet) or a Reply, it will include the related Tweet referenced to by its parent
      #
      # @note The field +tweet_fields: "referenced_tweets"+ option must be passed when fetching the tweet to access this data
      # @note The expansion +expansions: "referenced_tweets.id, referenced_tweets.id.author_id"+ options must be passed when fetching the tweet to access 
      # the full referenced tweets data
      #
      # @return [Array] A list of hashes containing the Tweet ID and reply type (either as a Retweet, Quoted Tweet, or reply) that this Tweet refers to if there are no tweet expansions.
      #
      # @return [Tweetkit::Response::Tweets] An object containing the expanded +Tweets+ (either as a Retweet, Quoted Tweet, or reply) that this Tweet refers to if tweet expansions are available.
      # @return [nil] If +tweet_fields: "referenced_tweets"+ is not passed as an option when fetching the Tweet
      def referenced_tweets
        expansions&.tweets || data["referenced_tweets"]
      end

      # Specifies the media keys (IDs) for the Tweet's attachments attachments (video, image, audio)
      #
      # @note The field +tweet_fields: "attachments"+ option must be passed when fetching the tweet to access this data
      #
      # @return [Array<String>] Array of media keys
      # @return [nil] If +tweet_fields: "attachments"+ is not passed as an option when fetching the Tweet
      def media_keys
        data.dig("attachments", "media_keys")
      end

      # Returns attachments (if any) present in this Tweet
      #
      # @note The expansion +expansions: "attachments.media_keys"+ option must be passed when fetching the tweet to access this data
      #
      # @return [Array<Tweetkit::Response::Expansions::MediaObject>] Array of +MediaObject+ objects from {#media_keys}
      # @return [nil] If the +MediaObject+ expansion (see {Tweetkit::Response::Expansions}) is empty or if {#media_keys} returns +nil+
      def attachments
        return if media_keys.nil?

        expansions&.media
      end

      # Specifies the media keys (IDs) for the Tweet's attachments attachments (video, image, audio)
      #
      # @note The field +poll_fields: "id"+ option must be passed when fetching the tweet to access this data
      #
      # @return [Array<String>] Array of poll IDs
      # @return [nil] If +poll_fields: "id"+ is not passed as an option when fetching the Tweet
      def poll_ids
        data.dig("attachments", "poll_ids")
      end

      # Returns polls (if any) present in this Tweet
      #
      # @note The expansion +expansions: "attachments.poll_ids"+ option must be passed when fetching the tweet to access this data
      #
      # @return [Array<Tweetkit::Response::Expansions::Poll>] Array of +Poll+ objects from {#poll_ids}
      # @return [nil] If the +Poll+ expansion (see {Tweetkit::Response::Expansions}) is empty or if {#poll_ids} returns +nil+
      def polls
        return if poll_ids.nil?

        expansions&.polls
      end

      # Contains details about the location tagged by the user in this Tweet, if they specified one.
      #
      # @note The field +tweet_fields: "geo"+ option must be passed when fetching the tweet to access this data
      # @note The expansion +expansions: "geo.place_id"+ option must be passed when fetching the tweet to access this data
      #
      # @return [Tweetkit::Response::Tweet::Geo]
      # @return [nil] If the +Geo+ expansion (see {Tweetkit::Response::Expansions}) is empty
      def geo
        return if data["geo"].nil?

        @geo ||= Geo.new(data["geo"])
      end

      # Context annotations for the Tweet.
      #
      # @note The field +tweet_fields: "context_annotations"+ option must be passed when fetching the tweet to access this data
      #
      # @see https://developer.twitter.com/en/docs/twitter-api/annotations/overview
      #
      # @return [Tweetkit::Response::Tweet::ContextAnnotations]
      # @return [nil] If +tweet_fields: "context_annotations"+ is not passed as an option when fetching the Tweet
      def context_annotations
        return if data["context_annotations"].nil?

        @context_annotations ||= ContextAnnotations.new(data["context_annotations"])
      end

      # Entity annotations for the Tweet.
      #
      # @note The field +tweet_fields: "entities"+ option must be passed when fetching the tweet to access this data
      #
      # @see https://developer.twitter.com/en/docs/twitter-api/annotations/overview
      #
      # @return [Tweetkit::Response::Tweet::EntityAnnotations]
      # @return [nil] If +tweet_fields: "entities"+ is not passed as an option when fetching the Tweet
      def entity_annotations
        return if data["entities"].nil?

        @entity_annotations ||= EntityAnnotations.new(data["entities"])
      end

      # Determines whether the Tweet is withheld or otherwise
      #
      # @note The field +tweet_fields: "withheld"+ option must be passed when fetching the tweet to access this data
      #
      # @return [Boolean]
      def withheld?
        withheld && !withheld.empty?
      end

      # Returns withholding details for withheld content
      #
      # @see https://help.twitter.com/en/rules-and-policies/tweet-withheld-by-country
      #
      # @note The field +tweet_fields: "withheld"+ option must be passed when fetching the tweet to access this data
      #
      # @return [Hash] Returns withholding details for withheld content
      # @return [nil] If +tweet_fields: "withheld"+ is not passed as an option when fetching the Tweet
      def withheld
        data["withheld"]
      end

      # Public, private, promoted, and organic metrics for the Tweet at the time of the request.
      #
      # @see https://developer.twitter.com/en/docs/twitter-api/metrics
      # @see #Tweetkit::Response::Tweet::Metrics
      #
      # @return [Tweetkit::Response::Tweet::Metrics]
      # @return [nil] If there are no metrics data returned with the Tweet
      def metrics
        return if data["public_metrics"].nil? && data["non_public_metrics"].nil? && data["organic_metrics"].nil? && data["promoted_metrics"].nil?

        @metrics ||= Metrics.new(
          public_metrics: data["public_metrics"], 
          private_metrics: data["non_public_metrics"], 
          organic_metrics: data["organic_metrics"], 
          promoted_metrics: data["promoted_metrics"]
        )
      end

      # Engagement metrics for the Tweet at the time of the request.
      #
      # @note The field +tweet_fields: "public_metrics"+ option must be passed when fetching the tweet to access this data
      #
      # @return [Tweetkit::Response::Tweet::Metrics::Public] Public engagement metrics for the Tweet at the time of the request.
      # @return [nil] If +tweet_fields: "public_metrics"+ is not passed as an option when fetching the Tweet
      def public_metrics
        metrics.public_metrics
      end

      # Non-public engagement metrics for the Tweet at the time of the request.
      #
      # @note The field +tweet_fields: "non_public_metrics"+ option must be passed when fetching the tweet to access this data
      # @note This is a private metric, and requires the use of OAuth 2.0 User Context authentication (https://developer.twitter.com/en/docs/authentication/oauth-2-0/application-only)
      #
      # @return [Tweetkit::Response::Tweet::Metrics::Private] Private engagement metrics for the Tweet at the time of the request.
      # @return [nil] If +tweet_fields: "private_metrics"+ is not passed as an option when fetching the Tweet or if the incorrect auth method is used.
      def private_metrics
        metrics.private_metrics
      end

      # Organic engagement metrics for the Tweet at the time of the request.
      #
      # @note The field +tweet_fields: "organic_metrics"+ option must be passed when fetching the tweet to access this data
      # @note This is a private metric, and requires the use of OAuth 2.0 User Context authentication (https://developer.twitter.com/en/docs/authentication/oauth-2-0/application-only)
      #
      # @return [Tweetkit::Response::Tweet::Metrics::Organic] Organic engagement metrics for the Tweet at the time of the request.
      # @return [nil] If +tweet_fields: "organic_metrics"+ is not passed as an option when fetching the Tweet or if the incorrect auth method is used.
      def organic_metrics
        metrics.organic_metrics
      end

      # Engagement metrics for the Tweet at the time of the request in a promoted context.
      #
      # @note The field +tweet_fields: "promoted_metrics"+ option must be passed when fetching the tweet to access this data
      # @note This is a private metric, and requires the use of OAuth 2.0 User Context authentication (https://developer.twitter.com/en/docs/authentication/oauth-2-0/application-only)
      #
      # @return [Tweetkit::Response::Tweet::Metrics::Promoted] Promoted engagement metrics for the Tweet at the time of the request.
      # @return [nil] If +tweet_fields: "promoted_metrics"+ is not passed as an option when fetching the Tweet or if the incorrect auth method is used.
      def promoted_metrics
        metrics.promoted_metrics
      end

      # Indicates if this Tweet contains URLs marked as sensitive, for example content suitable for mature audiences.
      #
      # @note The field +tweet_fields: "possibly_sensitive"+ option must be passed when fetching the tweet to access this data
      #
      # @return [Boolean] Indicates if this Tweet contains URLs marked as sensitive
      # @return [nil] If +tweet_fields: "possibly_sensitive"+ is not passed as an option when fetching the Tweet
      def possibly_sensitive
        data["possibly_sensitive"]
      end

      # Language of the Tweet, if detected by Twitter. Returned as a BCP47 language tag.
      #
      # @note The field +tweet_fields: "lang"+ option must be passed when fetching the tweet to access this data
      #
      # @return [String] Language of the Tweet, if detected by Twitter. Returned as a BCP47 language tag.
      # @return [nil] If +tweet_fields: "lang"+ is not passed as an option when fetching the Tweet
      def lang
        data["lang"]
      end

      # Shows who can reply to this Tweet.
      #
      # @note The field +tweet_fields: "reply_settings"+ option must be passed when fetching the tweet to access this data
      #
      # @return [String] Returns one of +everyone+, +mentionedUsers+, and +following+
      # @return [nil] If +tweet_fields: "reply_settings"+ is not passed as an option when fetching the Tweet
      def reply_settings
        data["reply_settings"]
      end

      # The name of the app the user Tweeted from.
      #
      # @note The field +tweet_fields: "source"+ option must be passed when fetching the tweet to access this data
      #
      # @return [String] The name of the app the user Tweeted from.
      # @return [nil] If +tweet_fields: "source"+ is not passed as an option when fetching the Tweet
      def source
        data["source"]
      end

      # The URL to the Tweet.
      #
      # @note The field +tweet_fields: "author_id"+ option must be passed when fetching the tweet to access this data
      #
      # @return [String] The URL to the tweet.
      # @return [nil] If +tweet_fields: "author_id"+ is not passed as an option when fetching the Tweet
      def url
        return if author_id.nil?

        "https://twitter.com/#{author_id}/status/#{id}"
      end

      alias_method :body, :text
      alias_method :content, :text
      alias_method :device, :source
      alias_method :date, :created_at
      alias_method :parent_tweet_id, :conversation_id
      alias_method :nsfw?, :possibly_sensitive
      alias_method :sensitive?, :possibly_sensitive
      alias_method :non_public_metrics, :private_metrics
      alias_method :language, :lang
      alias_method :media, :attachments
    end
  end
end
