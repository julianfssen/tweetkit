module Tweetkit
  class Response
    class Tweet
      class Annotations
        class Entity
          class Annotations
            attr_accessor :annotations

            def initialize(annotations)
              return unless annotations

              @annotations = annotations.collect { |annotation| Annotation.new(annotation) }
            end

            class Annotation
              attr_accessor :end, :probability, :start, :text, :type

              def initialize(annotation)
                @end = annotation["end"]
                @probability = annotation["probability"]
                @start = annotation["start"]
                @text = annotation["normalized_text"]
                @type = annotation["type"]
              end
            end
          end
        end
      end
    end
  end
end
