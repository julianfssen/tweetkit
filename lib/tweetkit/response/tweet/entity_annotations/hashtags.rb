module Tweetkit
  class Response
    class Tweet
      class EntityAnnotations
        # Contains details about text recognized as a Hashtag.
        class Hashtags
          include Enumerable

          attr_accessor :hashtags

          def initialize(hashtags)
            @hashtags = hashtags.collect { |hashtag| Hashtag.new(hashtag) }
          end

          def each(*args, &block)
            @cashtags.each(*args, &block)
          end

          class Hashtag
            attr_accessor :hashtag

            def initialize(hashtag)
              @hashtag = hashtag
            end

            # The start position (zero-based) of the recognized Hashtag within the Tweet. All start indices are inclusive.
            #
            # @return [Integer]
            def start
              hashtag["start"]
            end

            # The end position (zero-based) of the recognized Hashtag within the Tweet. This end index is exclusive.
            #
            # @return [Integer]
            def finish
              hashtag["end"]
            end

            # The text of the Hashtag.
            #
            # @return [String]
            def tag
              hashtag["tag"]
            end

            alias_method :end, :finish
          end
        end
      end
    end
  end
end
