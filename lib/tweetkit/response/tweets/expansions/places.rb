module Tweetkit::Response::Tweets::Expansions
  class Places
    attr_accessor :places
  
    def initialize(places)
      return unless places
  
      @places = places.collect { |place| Place.new(place) }
    end
  
    class Place
      attr_accessor :full_name, :id
  
      def initialize(place)
        @full_name = place['full_name']
        @id = place['id']
      end
    end
  end
end
