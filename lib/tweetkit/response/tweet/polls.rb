module Tweetkit
  class Response
    class Tweet
      class Polls
        def initialize(poll_ids)
          return unless poll_ids
      
          @poll_ids = poll_ids
        end

        # List of unique identifiers of polls present in the Tweets returned.
        # These are returned as a string in order to avoid complications with languages and tools that cannot handle large integers.
        # You can obtain the expanded list of polls by adding +{ expansions: "attachments.polls_ids" }+ in the request's query parameter.
        #
        # @return [Array<String>]
        def poll_ids
          @poll_ids
        end
      end
    end
  end
end
