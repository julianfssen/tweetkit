module Tweetkit
  class Response
    class Tweet
      # Contains details about text that has a special meaning in a Tweet.
      # To return this field, add +{ tweet_fields: "entities" } or { fields: { tweet: "entities" } }+ in the request's query parameter.
      class EntityAnnotations
        attr_accessor :entity_annotations

        def initialize(entity_annotations)
          return unless entity_annotations

          @entity_annotations = entity_annotations
        end

        # @see Annotations
        def annotations
          @annotations ||= Annotations.new(entity_annotations["annotations"])
        end

        # @see Cashtags
        def cashtags
          @cashtags ||= Cashtags.new(entity_annotations["cashtags"])
        end

        # @see Hashtags
        def hashtags
          @hashtags ||= Hashtags.new(entity_annotations["hashtags"])
        end

        # @see Mentions
        def mentions
          @mentions ||= Mentions.new(entity_annotations["mentions"])
        end

        # @see Urls
        def urls
          @urls ||= Urls.new(entity_annotations["urls"])
        end
      end
    end
  end
end
