module Tweetkit
  class Response
    class Expansions
      # Class for a Tweet's media objects (e.g. audio, images, videos)
      # with info on it's unique identifier (media key) and media type
      class MediaObject
        attr_accessor :media_object
      
        def initialize(media_object)
          @media_object = media_object
        end

        # Unique identifier of the expanded media content.
        #
        # @return [String]
        def media_key
          media_object["media_key"]
        end

        # Type of content (animated_gif, photo, video).
        #
        # @return [String]
        def type
          media_object["type"]
        end

        # A direct URL to the media file on Twitter.
        #
        # @return [String]
        def url
          media_object["url"]
        end

        # Only available when the media object is a video. Duration in milliseconds of the video.
        #
        # @return [Integer]
        def duration_ms
          media_object["duration_ms"]
        end

        # Height of this content in pixels.
        #
        # @return [Integer]
        def height
          media_object["height"]
        end

        # Non-public engagement metrics for the media content at the time of the request. 
        # Currently, the metrics only returns how many users played through to each quarter of a video.
        #
        # @note Requires user context authentication.
        #
        # @return [Hash]
        def non_public_metrics
          media_object["non_public_metrics"]
        end

        # Organic engagement metrics for the media content, tracked in an organic context, at the time of the request.
        # Currently, the metrics only returns how many users played through to each quarter of a video and the view count of the media object.
        #
        # @note Requires user context authentication.
        #
        # @return [Hash]
        def organic_metrics
          media_object["organic_metrics"]
        end

        # Engagement metrics for the media content, tracked when the tweet was promoted, at the time of the request. 
        # Currently, the metrics only returns how many users played through to each quarter of a video and the view count of the media object.
        #
        # @note Requires user context authentication.
        #
        # @return [Hash]
        def promoted_metrics
          media_object["promoted_metrics"]
        end

        # Public engagement metrics for the media content at the time of the request.
        #
        # @return [Hash]
        def public_metrics
          media_object["public_metrics"]
        end

        # URL to the static placeholder preview of this content.
        #
        # @return [String]
        def preview_image_url
          media_object["preview_image_url"]
        end

        # Width of this content in pixels.
        #
        # @return [Integer]
        def width
          media_object["width"]
        end

        # A description of an image to enable and support accessibility. 
        # Can be up to 1000 characters long. Alt text can only be added to images at the moment.
        #
        # @return [String]
        def alt_text
          media_object["alt_text"]
        end

        # Returns the media objects multiple display or playback variants, with different resolutions or formats (if available)
        #
        # @return [Array]
        def variants
          media_object["variants"]
        end

        alias_method :duration, :duration_ms
        alias_method :private_metrics, :non_public_metrics
        alias_method :preview_url, :preview_image_url
      end
    end
  end
end
