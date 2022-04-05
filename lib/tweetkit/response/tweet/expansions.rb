module Tweetkit::Response::Tweet
  class Expansions
    attr_accessor :media, :places, :polls, :tweets, :users
  
    def initialize(expansions)
      return unless expansions
  
      @media = Media.new(expansions['media'])
      @places = expansions['places']
      @polls = expansions['polls']
      @tweets = Tweets.new(expansions['tweets'])
      @users = Users.new(expansions['users'])
    end
  end
end
