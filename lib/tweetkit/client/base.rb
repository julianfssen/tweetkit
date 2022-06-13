module Tweetkit
  class Client
    module Base
      include Search
      include Tweets
    end
  end
end
