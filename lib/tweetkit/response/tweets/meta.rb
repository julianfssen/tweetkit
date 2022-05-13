module Tweetkit
  class Response
    class Tweets
      class Meta
        attr_accessor :data
                                  
        def initialize(meta)
          return unless meta
                                  
          @data = meta
        end
                                  
        def next_token
          @data["next_token"]
        end
                                  
        def previous_token
          @data["previous_token"]
        end
      end
    end
  end
end
