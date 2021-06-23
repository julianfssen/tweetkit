require 'tweetkit/search'

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

      def search(type = :tweet, **options, &block)
        search = Search.new
        yield search, self if block_given?
      end
    end
  end
end
