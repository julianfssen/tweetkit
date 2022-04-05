module Tweetkit::Response::Tweet
  class Annotations
    attr_accessor :context_annotations, :entity_annotations

    def initialize(context_annotations, entity_annotations)
      return unless context_annotations || entity_annotations

      @context_annotations = Context.new(context_annotations)
      @entity_annotations = Entity.new(entity_annotations)
    end
  end
end
