module Tweetkit
  class Response
    class Expansions
      class Tweets
        attr_accessor :tweets
      
        def initialize(tweets)
          @tweets ||= Tweetkit::Response::Tweets.new({ "data" => expansions["tweets"] })
        end

        def find(id)
          tweets.filter { |tweet| tweet.id == id }.first
        end

        # TODO
        def find_by(**options)
          tweets.filter { |tweet| tweet.id == id }.first
        end
      end
    end
  end
end
