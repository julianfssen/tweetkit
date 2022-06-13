module Tweetkit
  class Response
    class Tweet
      class EntityAnnotations
        # Contains details about annotations relative to the text within a Tweet.
        class Annotations
          attr_accessor :annotations

          def initialize(annotations)
            return unless annotations

            @annotations = annotations.collect { |annotation| Annotation.new(annotation) }
          end

          class Annotation
            attr_accessor :annotation

            alias_method :end, :finish
            alias_method :normalized_text, :text

            def initialize(annotation)
              @annotation = annotation
            end

            # The start position (zero-based) of the text used to annotate the Tweet. All start indices are inclusive.
            def start
              annotation["start"]
            end

            # The end position (zero based) of the text used to annotate the Tweet. While all other end indices are exclusive, this one is inclusive.
            def finish
              annotation["end"]
            end

            # The confidence score for the annotation as it correlates to the Tweet text.
            def probability
              annotation["probability"]
            end

            # The description of the type of entity identified when the Tweet text was interpreted.
            def type
              annotation["type"]
            end

            # The text used to determine the annotation type.
            def text
              annotation["normalized_text"]
            end
          end
        end
      end
    end
  end
end
