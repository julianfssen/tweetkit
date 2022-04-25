module Tweetkit
  class Response
    class Tweet
      class Annotations
        class Entity
          include Enumerable

          attr_accessor :annotations, :cashtags, :hashtags, :mentions, :urls

          def initialize(entity_annotations)
            return unless entity_annotations

            @annotations = Annotations.new(entity_annotations["annotations"])
            @cashtags = Cashtags.new(entity_annotations["cashtags"])
            @hashtags = Hashtags.new(entity_annotations["hashtags"])
            @mentions = Mentions.new(entity_annotations["mentions"])
            @urls = Urls.new(entity_annotations["urls"])
          end

          def each(*args, &block)
            annotations.each(*args, &block)
          end
        end
      end
    end
  end
end
