module Tweetkit
  class Client
    module Tweets
      def tweet(id, **options)
        get "tweets/#{id}", options
      end

      def tweets(ids, **options)
        ids = ids.join(',') if ids.is_a? Array
        get 'tweets', options.merge!({ ids: ids })
      end
    end
  end
end
