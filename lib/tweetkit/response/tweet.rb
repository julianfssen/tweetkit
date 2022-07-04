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
      # @note The field +tweet.fields=created_at+ must be specified when fetching the tweet to access this data
      #
      # @return [String] The time (ISO 8601) the Tweet was created 
      def created_at
        data["created_at"]
      end

      # Unique identifier of this user
      # 
      # @note The expansion +expansions=author_id+ must be specified when fetching the tweet to access this data
      #
      # @return [String] Unique identifier of this user
      def author_id
        data["author_id"]
      end

      def author
        expansions&.users.find { |user| user.id == author_id }
      end

      # Returns the origin / root Tweet ID of the conversation (which includes direct replies, replies of replies)
      # 
      # @note The field +tweet.fields=conversation_id+ must be specified when fetching the tweet to access this data
      #
      # @return [String] Returns the origin / root Tweet ID of the conversation
      def conversation_id
        data["conversation_id"]
      end

      def conversation
        expansions&.tweets.find { |tweet| tweet.conversation_id == conversation_id }
      end

      # If this Tweet is a reply, returns the user ID of the parent tweet's author
      # 
      # @note The expansion +expansions=in_reply_to_user_id+ must be specified when fetching the tweet to access this data
      #
      # @return [String] If this Tweet is a Reply, indicates the user ID of the parent Tweet's author.
      def in_reply_to_user_id
        data["in_reply_to_user_id"]
      end

      def reply_to
        expansions&.users.find { |user| user.id == in_reply_to_user_id }
      end

      # A list of Tweets this Tweet refers to. For example, if the parent Tweet is a Retweet, a Retweet with comment (also known as Quoted Tweet) or a Reply, it will include the related Tweet referenced to by its parent
      #
      # @note The field +tweet.fields=referenced_tweets+ must be specified when fetching the tweet to access this data
      #
      # @return [Array] A list of hashes containing the Tweet ID and reply type (either as a Retweet, Quoted Tweet, or reply) that this Tweet refers to if there are no tweet expansions.
      #
      # @return [Tweetkit::Response::Tweets] An object containing the expanded Tweets (either as a Retweet, Quoted Tweet, or reply) that this Tweet refers to if tweet expansions are available.
      def referenced_tweets
        expansions&.tweets || data["referenced_tweets"]
      end

      # Specifies the type of attachments (if any) present in this Tweet
      #
      # @note The field +tweet.fields=attachments+ must be specified when fetching the tweet to access this data
      #
      # @return [Attachments]
      def attachments
        return if data.dig("attachments", "media_keys").nil?

        @attachments ||= Attachments.new(data["attachments"]["media_keys"])
      end

      # Specifies the type of attachments (if any) present in this Tweet
      #
      # @note The field +tweet.fields=attachments+ must be specified when fetching the tweet to access this data
      #
      # @return [Polls]
      def polls
        return if data.dig("attachments", "poll_ids").nil?

        @polls ||= Polls.new(data["attachments"]["poll_ids"])
      end

      # Contains details about the location tagged by the user in this Tweet, if they specified one.
      #
      # @note The field +tweet.fields=geo+ must be specified when fetching the tweet to access this data
      #
      # @return [Geo]
      def geo
        return if data["geo"].nil?

        @geo ||= Geo.new(data["geo"])
      end

      # Context annotations for the Tweet.
      #
      # @note The field +tweet.fields=context_annotations+ must be specified when fetching the tweet to access this data
      #
      # @see https://developer.twitter.com/en/docs/twitter-api/annotations/overview
      #
      # @return [ContextAnnotations]
      def context_annotations
        return if data["context_annotations"].nil?

        @context_annotations ||= ContextAnnotations.new(data["context_annotations"])
      end


      # Entity annotations for the Tweet.
      #
      # @note The field +tweet.fields=entities+ must be specified when fetching the tweet to access this data
      #
      # @see https://developer.twitter.com/en/docs/twitter-api/annotations/overview
      #
      # @return [EntityAnnotations]
      def entity_annotations
        return if data["entities"].nil?

        @entity_annotations ||= EntityAnnotations.new(data["entities"])
      end

      # Determines whether the Tweet is withheld or otherwise
      #
      # @return [Boolean]
      def withheld?
        withheld && !withheld.empty?
      end

      # Returns withholding details for withheld content
      #
      # @see https://help.twitter.com/en/rules-and-policies/tweet-withheld-by-country
      #
      # @note The field +tweet.fields=withheld+ must be specified when fetching the tweet to access this data
      #
      # @return [Hash] Returns withholding details for withheld content
      def withheld
        data["withheld"]
      end

      # Public, private, promoted, and organic metrics for the Tweet at the time of the request.
      #
      # @return [Tweetkit::Response::Tweet::Metrics]
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
      # @note The field +tweet.fields=public_metrics+ must be specified when fetching the tweet to access this data
      #
      # @return [Hash] Engagement metrics for the Tweet at the time of the request.
      def public_metrics
        metrics.public_metrics
      end

      # Non-public engagement metrics for the Tweet at the time of the request.
      #
      # @note The field +tweet.fields=non_public_metrics+ must be specified when fetching the tweet to access this data
      # @note This is a private metric, and requires the use of OAuth 2.0 User Context authentication
      #
      # @return [Hash] Non-public engagement metrics for the Tweet at the time of the request.
      def private_metrics
        metrics.private_metrics
      end

      # Organic engagement metrics for the Tweet at the time of the request.
      #
      # @note The field +tweet.fields=organic_metrics+ must be specified when fetching the tweet to access this data
      # @note This is a private metric, and requires the use of OAuth 2.0 User Context authentication
      #
      # @return [Hash] Organic engagement metrics for the Tweet at the time of the request.
      def organic_metrics
        metrics.organic_metrics
      end

      # Engagement metrics for the Tweet at the time of the request in a promoted context.
      #
      # @note The field +tweet.fields=promoted_metrics+ must be specified when fetching the tweet to access this data
      # @note This is a private metric, and requires the use of OAuth 2.0 User Context authentication
      #
      # @return [Hash] Engagement metrics for the Tweet at the time of the request in a promoted context.
      def promoted_metrics
        metrics.promoted_metrics
      end

      # Indicates if this Tweet contains URLs marked as sensitive, for example content suitable for mature audiences.
      #
      # @note The field +tweet.fields=possibly_sensitve+ must be specified when fetching the tweet to access this data
      #
      # @return [Boolean] Indicates if this Tweet contains URLs marked as sensitive
      def possibly_sensitive
        data["possibly_sensitive"]
      end

      # Language of the Tweet, if detected by Twitter. Returned as a BCP47 language tag.
      #
      # @note The field +tweet.fields=lang+ must be specified when fetching the tweet to access this data
      #
      # @return [String] Language of the Tweet, if detected by Twitter. Returned as a BCP47 language tag.
      def lang
        data["lang"]
      end

      # Shows who can reply to this Tweet.
      #
      # @note The field +tweet.fields=reply_settings+ must be specified when fetching the tweet to access this data
      #
      # @return [String] Returns one of +everyone+, +mentionedUsers+, and +following+
      def reply_settings
        data["reply_settings"]
      end

      # The name of the app the user Tweeted from.
      #
      # @note The field +tweet.fields=source+ must be specified when fetching the tweet to access this data
      #
      # @return [String] The name of the app the user Tweeted from.
      def source
        data["source"]
      end

      # The URL to the Tweet.
      #
      # @note The expansion +expansions=author_id+ must be specified when fetching the tweet to access this data
      #
      # @return [String] The URL to the tweet.
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
    end
  end
end
