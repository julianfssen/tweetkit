module Tweetkit
  class Response
    class Tweets
      class Expansions
        class Tweets
          attr_accessor :tweets
        
          def initialize(tweets)
            return unless tweets
        
            @tweets = tweets.collect { |tweet| Tweet.new(tweet) }
          end
        end
      end
    end
  end
end
