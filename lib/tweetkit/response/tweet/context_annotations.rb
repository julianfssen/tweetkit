module Tweetkit
  class Response
    class Tweet
      # Contains context annotations for the Tweet.
      # To return this field, add +{ tweet_fields: "context_annotations" }+ or +{ fields: { tweet: "context_annotations" } }+ in the request's query parameter.
      class ContextAnnotations
        include Enumerable

        def initialize(context_annotations)
          return unless context_annotations

          @context_annotations = context_annotations.collect { |context_annotation| ContextAnnotation.new(context_annotation) }
        end

        def each(*args, &block)
          @context_annotations.each(*args, &block)
        end

        def last
          @tweets.last
        end

        def [](key)
          if key.kind_of?(Integer)
            @context_annotations[key]
          else
            @context_annotations.send(:[], key)
          end
        end

        class ContextAnnotation
          def initialize(context_annotation)
            @context_annotation = context_annotation
          end

          # Contains elements which identify detailed information regarding the domain classification based on Tweet text.
          #
          # @return [Hash]
          def domain
            @context_annotation["domain"]
          end

          # Contains the numeric value of the domain.
          #
          # @return [String]
          def domain_id
            domain["id"]
          end

          # Domain name based on the Tweet text.
          #
          # @return [String]
          def domain_name
            domain["name"]
          end

          # Long form description of domain classification.
          #
          # @return [String]
          def domain_description
            domain["description"]
          end

          # Contains elements which identify detailed information regarding the domain classification bases on Tweet text.
          #
          # @return [Hash]
          def entity
            @context_annotation["entity"]
          end

          # Unique value which correlates to an explicitly mentioned Person, Place, Product or Organization
          #
          # @return [String]
          def entity_id
            entity["id"]
          end

          # Name or reference of entity referenced in the Tweet.
          #
          # @return [String]
          def entity_name
            entity["name"]
          end

          # Additional information regarding referenced entity.
          #
          # @return [String]
          def entity_description
            entity["description"]
          end
        end
      end
    end
  end
end
