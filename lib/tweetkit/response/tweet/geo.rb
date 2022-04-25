module Tweetkit
  class Response
    class Tweet
      class Geo
        attr_accessor :coordinates, :place_id

        def initialize(geo)
          return unless geo

          @coordinates = Coordinates.new(geo["coordinates"])
          @place_id = geo["place_id"]
        end

        class Coordinates
          attr_accessor :coordinates, :type

          def initialize(coordinates)
            @coordinates = coordinates["coordinates"]
            @type = coordinates["point"]
          end

          def x
            coordinates[0]
          end

          def y
            coordinates[0]
          end
        end
      end
    end
  end
end
