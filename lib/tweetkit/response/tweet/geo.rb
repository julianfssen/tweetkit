module Tweetkit
  class Response
    class Tweet
      # Contains details about the location tagged by the user in this Tweet, if they specified one.
      # To return this field, add +{ tweet_fields: "geo" } or { fields: { tweet: "geo" } }+ in the request's query parameter.
      class Geo
        attr_accessor :geo

        def initialize(geo)
          return unless geo

          @geo = geo
        end

        # A pair of decimal values representing the precise location of the user (latitude, longitude). This value be null unless the user explicitly shared their precise location.
        #
        # @return [Array<Float>]
        def coordinates
          geo["coordinates"]["coordinates"]
        end

        # Describes the type of coordinate. The only value supported at present is Point.
        #
        # @return [String]
        def coordinate_type
          geo["coordinates"]["type"]
        end

        # The unique identifier of the place, if this is a point of interest tagged in the Tweet.
        # You can obtain the expanded object in includes.places by adding expansions=geo.place_id in the request's query parameter.
        #
        # @return [String]
        def place_id
          geo["place_id"]
        end

        # @return [Float]
        def x_coordinate
          coordinates[0]
        end

        # @return [Float]
        def y_coordinate
          coordinates[1]
        end

        alias_method :x, :x_coordinate
        alias_method :y, :y_coordinate
      end
    end
  end
end
