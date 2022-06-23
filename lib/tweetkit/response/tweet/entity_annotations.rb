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

        # @return Tweetkit::Response::Tweet::EntityAnnotations::Annotations
        def annotations
          return unless entity_annotations["annotations"]

          @annotations ||= Annotations.new(entity_annotations["annotations"])
        end

        # @return Tweetkit::Response::Tweet::EntityAnnotations::Cashtags
        def cashtags
          return unless entity_annotations["cashtags"]

          @cashtags ||= Cashtags.new(entity_annotations["cashtags"])
        end

        # @return Tweetkit::Response::Tweet::EntityAnnotations::Hashtags
        def hashtags
          return unless entity_annotations["hashtags"]

          @hashtags ||= Hashtags.new(entity_annotations["hashtags"])
        end

        # @return Tweetkit::Response::Tweet::EntityAnnotations::Mentions
        def mentions
          return unless entity_annotations["mentions"]

          @mentions ||= Mentions.new(entity_annotations["mentions"])
        end

        # @return Tweetkit::Response::Tweet::EntityAnnotations::Urls
        def urls
          return unless entity_annotations["urls"]

          @urls ||= Urls.new(entity_annotations["urls"])
        end
      end
    end
  end
end
