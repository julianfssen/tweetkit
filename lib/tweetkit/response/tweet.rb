module Tweetkit
  class Response
    # Class for individual Tweets
    class Tweet
      attr_accessor :data

      def initialize(data)
        if data["data"].nil?
          @data = data
        else
          @data = data["data"]
        end
      end

      # Unique ID for this Tweet
      # 
      # @return [String] Unique ID for this Tweet
      def id
        data["id"]
      end

      # @see text
      def body
        text
      end

      # @see text
      def content
        text
      end

      # The content of the Tweet
      # 
      # @return [String] The content of the Tweet
      def text
        data["text"]
      end

      # @see created_at
      def date
        created_at
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

      # @see conversation_id
      def parent_tweet_id
        conversation_id
      end

      # Returns the origin / root Tweet ID of the conversation (which includes direct replies, replies of replies)
      # 
      # @note The field +tweet.fields=conversation_id+ must be specified when fetching the tweet to access this data
      #
      # @return [String] Returns the origin / root Tweet ID of the conversation
      def conversation_id
        data["conversation_id"]
      end

      # @see in_reply_to_user_id
      def reply_to
        in_reply_to_user_id
      end

      # If this Tweet is a reply, returns the user ID of the parent tweet's author
      # 
      # @note The expansion +expansions=in_reply_to_user_id+ must be specified when fetching the tweet to access this data
      #
      # @return [String] If this Tweet is a Reply, indicates the user ID of the parent Tweet's author.
      def in_reply_to_user_id
        data["in_reply_to_user_id"]
      end

      # A list of Tweets this Tweet refers to. For example, if the parent Tweet is a Retweet, a Retweet with comment (also known as Quoted Tweet) or a Reply, it will include the related Tweet referenced to by its parent
      #
      # @note The field +tweet.fields=referenced_tweets+ must be specified when fetching the tweet to access this data
      #
      # @return [Array] A list of Tweets this Tweet refers to
      def referenced_tweets
        data["referenced_tweets"]
      end

      # Specifies the type of attachments (if any) present in this Tweet
      #
      # @note The field +tweet.fields=referenced_tweets+ must be specified when fetching the tweet to access this data
      #
      # @return TODO
      def attachments
        @attachments
      end

      # Contains details about the location tagged by the user in this Tweet, if they specified one.
      #
      # @note The field +tweet.fields=referenced_tweets+ must be specified when fetching the tweet to access this data
      #
      # @return TODO
      def geo
      end

      # Context annotations for the Tweet.
      #
      # @note The field +tweet.fields=context_annotations+ must be specified when fetching the tweet to access this data
      #
      # @see https://developer.twitter.com/en/docs/twitter-api/annotations/overview
      #
      # @return TODO
      def context_annotations
        @annotations.context_annotations || nil
      end

      # @see entities
      def entity_annotations
        entities
      end

      # Entity annotations for the Tweet.
      #
      # @note The field +tweet.fields=entities+ must be specified when fetching the tweet to access this data
      #
      # @see https://developer.twitter.com/en/docs/twitter-api/annotations/overview
      #
      # @return TODO
      def entities
        @annotations.entity_annotations || nil
      end

      # Determines whether the Tweet is withheld or otherwise
      #
      # @see withheld
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

      def metrics
        Metrics.new(public_metrics: , private_metrics:, organic_metrics:, promoted_metrics:)
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

      # @see private_metrics
      def non_public_metrics
        private_metrics
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

      # @see possibility_sensitive
      def nsfw?
        possibly_sensitive
      end

      # @see possibility_sensitive
      def sensitive?
        possibly_sensitive
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

      # @see source
      def device
        source
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
        "https://twitter.com/#{author_id}/status/#{id}"
      end

      # @see ContextAnnotations
      def context_annotations
        @context_annotations ||= ContextAnnotations.new(data["context_annotations"])
      end

      # @see EntityAnnotations
      def entity_annotations
        @entity_annotations ||= EntityAnnotations.new(data["entities"])
      end

      # @see Attachments
      def attachments
        @attachments ||= Attachments.new(data["attachments"]["media_keys"])
      end

      def polls
        @polls ||= Polls.new(data["attachments"]["poll_ids"])
      end
    end
  end
end
