module Tweetkit
  class Client
    module Tweets
      def tweet(id, options = {})
        get "tweets/#{id}", options
      end
    end
  end
end
