module Tweetkit
  class Response
    class Tweets
      class Expansions
        # Class for a Tweet's media objects (e.g. audio, images, videos)
        class Media
          attr_accessor :media
        
          def initialize(media)
            return unless media
        
            @media = media.collect { |media_object| MediaObject.new(media_object) }
          end
        
          # Class for a media object, with info on it's unique identifier (media key) and media type
          class MediaObject
            attr_accessor :media_key, :type
        
            def initialize(media_object)
              @media_key = media_object["media_key"]
              @type = media_object["type"]
            end
          end
        end
      end
    end
  end
end
