module Tweetkit
  class Response
    class Tweet
      class EntityAnnotations
        # Contains details about text recognized as a Cashtag.
        class Cashtags
          include Enumerable

          attr_accessor :cashtags

          def initialize(cashtags)
            @cashtags = cashtags.collect { |cashtag| Cashtag.new(cashtag) }
          end

          def each(*args, &block)
            @cashtags.each(*args, &block)
          end

          class Cashtag
            attr_accessor :cashtag

            def initialize(cashtag)
              @cashtag = cashtag
            end

            # The start position (zero-based) of the recognized Cashtag within the Tweet. All start indices are inclusive.
            #
            # @return [Integer]
            def start
              cashtag["start"]
            end

            # The end position (zero-based) of the recognized Cashtag within the Tweet. This end index is exclusive.
            #
            # @return [Integer]
            def finish
              cashtag["end"]
            end

            # The text of the Cashtag.
            #
            # @return [String]
            def tag
              cashtag["tag"]
            end

            alias_method :end, :finish
          end
        end
      end
    end
  end
end
