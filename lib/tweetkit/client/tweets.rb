require "tweetkit/client/search"

module Tweetkit
  module Client
    module Tweets
      def tweet(id, **options)
        get("tweets/#{id}", **options)
      end

      def tweets(ids, **options)
        if ids.is_a? Array
          ids = ids.join(",")
        else
          ids = ids.delete(" ")
        end
        get("tweets", **options.merge!({ ids: ids }))
      end


      def post_tweet(**options)
        post("tweets", **options)
      end

      def delete_tweet(id)
        delete("tweets/#{id}")
      end
    end
  end
end
