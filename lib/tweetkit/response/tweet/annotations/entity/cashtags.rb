module Tweetkit::Response::Tweet::Annotations::Entity
  class Cashtags
    attr_accessor :cashtags

    def initialize(cashtags)
      return unless cashtags

      @cashtags = cashtags.collect { |cashtag| Cashtag.new(cashtag) }
    end

    class Cashtag
      attr_accessor :end, :start, :tag

      def initialize(cashtag)
        @end = cashtag['end']
        @start = cashtag['start']
        @tag = cashtag['tag']
      end
    end
  end
end
