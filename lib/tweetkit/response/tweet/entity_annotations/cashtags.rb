module Tweetkit
  class Response
    class Tweet
      class EntityAnnotations
        # Contains details about text recognized as a Cashtag.
        class Cashtags
          attr_accessor :cashtags

          def initialize(cashtags)
            return unless cashtags

            @cashtags = cashtags.collect { |cashtag| Cashtag.new(cashtag) }
          end

          class Cashtag
            attr_accessor :cashtag

            alias_method :end, :finish

            def initialize(cashtag)
              @cashtag = cashtag
            end

            # The start position (zero-based) of the recognized Cashtag within the Tweet. All start indices are inclusive.
            def start
              cashtag["start"]
            end

            # The end position (zero-based) of the recognized Cashtag within the Tweet. This end index is exclusive.
            def finish
              cashtag["end"]
            end

            # The text of the Cashtag.
            def tag
              cashtag["tag"]
            end
          end
        end
      end
    end
  end
end
