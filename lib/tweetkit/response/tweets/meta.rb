module Tweetkit
  class Response
    class Tweets
      # Class for pagination tokens and other Twitter API metadata
      #
      # @see https://developer.twitter.com/en/docs/twitter-api/pagination
      class Meta
        attr_accessor :data
                                  
        def initialize(meta)
          return unless meta
                                  
          @data = meta
        end
                                  
        # The token required to fetch the next page of results
        #
        # @return [String]
        def next_token
          @data["next_token"]
        end
                                  
        # The token required to fetch the next page of results
        #
        # @return [String]
        def previous_token
          @data["previous_token"]
        end
      end
    end
  end
end
