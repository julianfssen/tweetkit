require_relative 'search/search'

module Tweetkit
  class Client
    module Tweets
      def tweet(id, **options)
        get "tweets/#{id}", **options
      end

      def tweets(ids, **options)
        if ids.is_a? Array
          ids = ids.join(',')
        else
          ids = ids.delete(' ')
        end
        get 'tweets', **options.merge!({ ids: ids })
      end

      def search(query = '', type: :tweet, **options, &block)
        search = Search.new(query)
        search.evaluate(&block) if block_given?
        get 'tweets/search/recent', **options.merge!({ query: search.current_query })
      end

      def post_tweet(**options)
        post "tweets", **options
      end

      def delete_tweet(id)
        delete "tweets/#{id}"
      end
    end
  end
end
