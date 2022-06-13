module Tweetkit
  class Response
    class Tweets
      # Class for initializing expansions data and converting them into their respective classes
      # @see https://developer.twitter.com/en/docs/twitter-api/expansions
      class Expansions
        attr_accessor :media, :places, :polls, :tweets, :users
      
        def initialize(expansions)
          return unless expansions
      
          @media = Media.new(expansions["media"])
          @places = Places.new(expansions["places"])
          @polls = Polls.new(expansions["polls"])
          @tweets = Tweets.new(expansions["tweets"])
          @users = Users.new(expansions["users"])
        end
      end
    end
  end
end
