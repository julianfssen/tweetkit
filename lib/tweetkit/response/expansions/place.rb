module Tweetkit
  class Response
    class Expansions
      # Class for a place objects (i.e. location data) detected in a Tweet
      class Place
        attr_accessor :place
      
        def initialize(place)
          @place = place
        end

        # The unique identifier of the expanded place, if this is a point of interest tagged in the Tweet.
        #
        # @return [String]
        def id
          place["id"]
        end

        # The full location name for the place object.
        #
        # @return [String]
        def full_name
          place["full_name"]
        end

        # Returns the identifiers of known places that contain the referenced place.
        #
        # @return [Array]
        def contained_within
          place["contained_within"]
        end

        # The full-length name of the country this place belongs to.
        #
        # @return [String]
        def country
          place["country"]
        end

        # The ISO Alpha-2 country code this place belongs to.
        #
        # @return [String]
        def country_code
          place["country_code"]
        end

        # Contains place details in GeoJSON format.
        #
        # @see https://geojson.org/
        #
        # @return [Hash]
        def geo
          place["geo"]
        end

        # The short name of this place.
        #
        # @return [String]
        def name
          place["name"]
        end

        # Specifies the particular type of information represented by this place information, such as a city name, or a point of interest.
        #
        # @return [String]
        def place_type
          place["place_type"]
        end
      end
    end
  end
end
