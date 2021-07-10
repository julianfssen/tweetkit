require 'tweetkit/search'

module Tweetkit
  class Client
    module Tweets
      def tweet(id, **options)
        get "tweets/#{id}", options
      end

      def tweets(ids, **options)
        if ids.is_a? Array
          ids = ids.join(',')
        else
          ids = ids.delete(' ')
        end
        get 'tweets', options.merge!({ ids: ids })
      end

      def search(query = '', type: :tweet, **options, &block)
        search = Search.new(query)
        search.setup(&block) if block_given?
        get 'tweets/search/recent', options.merge!({ query: search.combined_query })
      end
    end
  end
end
