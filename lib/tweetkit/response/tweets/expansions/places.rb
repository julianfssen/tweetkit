module Tweetkit
  class Response
    class Tweets
      class Expansions
        # Class for a place objects (i.e. location data) detected in a Tweet
        class Places
          attr_accessor :places
        
          def initialize(places)
            return unless places
        
            @places = places.collect { |place| Place.new(place) }
          end
        
          # Class for a place or location detected in a Tweet
          class Place
            attr_accessor :full_name, :id
        
            def initialize(place)
              @full_name = place['full_name']
              @id = place['id']
            end
          end
        end
      end
    end
  end
end
