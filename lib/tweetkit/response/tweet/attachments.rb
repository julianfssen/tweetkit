module Tweetkit
  class Response
    class Tweet
      class Attachments
        def initialize(media_keys)
          return unless media_keys
      
          @media_keys = media_keys
        end

        # List of unique identifiers of media attached to this Tweet. 
        # These identifiers use the same media key format as those returned by the Media Library (https://developer.twitter.com/en/docs/twitter-ads-api/creatives/guides/media-library).
        # You can obtain the expanded list of attachments by adding +{ expansions: "attachments.media_keys"}+ in the request
        def media_keys
          @media_keys
        end
      end
    end
  end
end
