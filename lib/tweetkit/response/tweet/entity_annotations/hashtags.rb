module Tweetkit
  class Response
    class Tweet
      class EntityAnnotations
        # Contains details about text recognized as a Hashtag.
        class Hashtags
          attr_accessor :hashtags

          def initialize(hashtags)
            return unless hashtags

            @hashtags = hashtags.collect { |hashtag| Hashtag.new(hashtag) }
          end

          class Hashtag
            attr_accessor :hashtag

            alias_method :end, :finish

            def initialize(hashtag)
              @hashtag = hashtag
            end

            # The start position (zero-based) of the recognized Hashtag within the Tweet. All start indices are inclusive.
            def start
              hashtag["start"]
            end

            # The end position (zero-based) of the recognized Hashtag within the Tweet. This end index is exclusive.
            def finish
              hashtag["end"]
            end

            # The text of the Hashtag.
            def tag
              hashtag["tag"]
            end
          end
        end
      end
    end
  end
end
