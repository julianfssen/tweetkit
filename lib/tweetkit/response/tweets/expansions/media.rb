module Tweetkit::Response::Tweets::Expansions
  class Media
    attr_accessor :media
  
    def initialize(media)
      return unless media
  
      @media = media.collect { |media_object| MediaObject.new(media_object) }
    end
  
    class MediaObject
      attr_accessor :media_key, :type
  
      def initialize(media_object)
        @media_key = media_object["media_key"]
        @type = media_object["type"]
      end
    end
  end
end
