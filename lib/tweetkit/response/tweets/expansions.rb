module Tweetkit
  class Response
    class Tweets
      class Expansions
        attr_accessor :media, :places, :polls, :tweets, :users
      
        def initialize(expansions)
          # debugger
          return unless expansions
      
          @media = Media.new(expansions["media"])
          @places = expansions["places"]
          @polls = expansions["polls"]
          @tweets = Tweets.new(expansions["tweets"])
          @users = Users.new(expansions["users"])
        end
      end
    end
  end
end
