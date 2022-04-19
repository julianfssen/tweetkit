module Tweetkit
  class Client
    module Tweets
      def tweet(id, **options)
        get "tweets/#{id}", resource: :tweet, **options
      end

      def tweets(ids, **options)
        if ids.is_a? Array
          ids = ids.join(",")
        else
          ids = ids.delete(" ")
        end

        get "tweets", ids: ids, resource: :tweets, **options
      end

      def post_tweet(**options)
        post "tweets", resource: :tweet, **options
      end

      def delete_tweet(id)
        delete "tweets/#{id}"
      end
    end
  end
end
