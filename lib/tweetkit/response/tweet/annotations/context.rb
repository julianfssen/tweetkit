module Tweetkit
  class Response
    class Tweet
      class Annotations
        class Context
          include Enumerable

          attr_accessor :annotations

          def initialize(annotations)
            return unless annotations

            @annotations = annotations.collect { |annotation| Annotation.new(annotation) }
          end

          def each(*args, &block)
            annotations.each(*args, &block)
          end

          class Annotation
            attr_accessor :domain, :entity

            def initialize(annotation)
              @domain = annotation["domain"]
              @entity = annotation["entity"]
            end
          end
        end
      end
    end
  end
end
