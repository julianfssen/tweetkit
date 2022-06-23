module Tweetkit
  class Response
    class Tweet
      class EntityAnnotations
        # Contains details about annotations relative to the text within a Tweet.
        class Annotations
          include Enumerable

          attr_accessor :annotations

          def initialize(annotations)
            @annotations = annotations.collect { |annotation| Annotation.new(annotation) }
          end

          def each(*args, &block)
            @annotations.each(*args, &block)
          end

          class Annotation
            attr_accessor :annotation

            def initialize(annotation)
              @annotation = annotation
            end

            # The start position (zero-based) of the text used to annotate the Tweet. All start indices are inclusive.
            #
            # @return [Integer]
            def start
              annotation["start"]
            end

            # The end position (zero based) of the text used to annotate the Tweet. While all other end indices are exclusive, this one is inclusive.
            #
            # @return [Integer]
            def finish
              annotation["end"]
            end

            # The confidence score for the annotation as it correlates to the Tweet text.
            #
            # @return [Float]
            def probability
              annotation["probability"]
            end

            # The description of the type of entity identified when the Tweet text was interpreted.
            #
            # @return [String]
            def type
              annotation["type"]
            end

            # The text used to determine the annotation type.
            #
            # @return [String]
            def text
              annotation["normalized_text"]
            end

            alias_method :end, :finish
            alias_method :normalized_text, :text
          end
        end
      end
    end
  end
end
