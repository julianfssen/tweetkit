module Tweetkit
  class Client
    # Methods to interact with Twitter v2's Tweets endpoints
    #
    # @see https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/introduction
    module Tweets
      # Fetches a variety of information about a single Tweet specified by the requested ID
      #
      # @param [Integer, String] id The Tweet ID to fetch
      #
      # @option options [Hash] "" See {#Tweetkit::RequestOptionsBuilder}
      #
      # @example Fetching a Tweet
      #   # Fetching a Tweet with a given ID
      #   client.tweet(123456789)
      #   
      #   # Fetching a Tweet with a given ID and options
      #   client.tweet(123456789)
      #
      # @return [Tweetkit::Response::Tweet] An instance of {#Tweetkit::Response::Tweet}
      def tweet(id, **options)
        get("tweets/#{id}", resource: :tweet, **options)
      end

      # Returns a collection of Tweets with the given IDs
      #
      # @param [Array<String, Integer>, String] ids The Tweet IDs to fetch
      #
      # @option options [Hash] "" See {#Tweetkit::RequestOptionsBuilder}
      #
      # @example Fetching Tweets
      #   # Fetching a collection of Tweets with an array of IDs
      #   client.tweets([123456789, 234567890, 3456789012])
      #   
      #   # Fetching a collection of Tweets with a comma-concatenated string of IDs
      #   client.tweets('123456789, 234567890, 345678901')
      #
      # @return [Tweetkit::Response::Tweets] An instance of +Tweetkit::Response::Tweets+
      def tweets(ids, **options)
        if ids.is_a? Array
          ids = ids.join(",")
        else
          ids = ids.delete(" ")
        end

        get("tweets", ids: ids, resource: :tweets, **options)
      end

      # Posts a Tweet with the given content
      #
      # @param [Array<String, Integer>, String] text The Tweet text to be posted. Required only if the Tweet does not contain any media (images, videos)
      #
      # @option options [Hash] "" See {#Tweetkit::RequestOptionsBuilder}
      #
      # @example Posting a Tweet
      #   # Fetching a collection of Tweets with an array of IDs
      #   client.post_tweet(text: "Hello!")
      #
      # @return [Tweetkit::Response::Tweet] An instance of +Tweetkit::Response::Tweet+ of the posted Tweet
      def post_tweet(text: nil, **options)
        post("tweets", resource: :tweet, text: text, **options)
      end

      # Deletes a Tweet with the given ID
      #
      # @param [Integer, String] id The Tweet ID to delete
      #
      # @example Deleting a Tweet
      #   # Fetching a collection of Tweets with an array of IDs
      #   client.delete_tweet(123456789)
      #
      # @return [Boolean] Returns +true+ if the Tweet is deleted, +false+ if otherwise.
      def delete_tweet(id)
        delete("tweets/#{id}")
      end
    end
  end
end
