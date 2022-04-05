module Tweetkit
  module Response
    class Tweet
      attr_accessor :annotations, :attachments, :data

      def initialize(tweet)
        @data = Struct.new(tweet)
        @annotations = Annotations.new(data['context_annotations'], data['entities'])
        @attachments = Attachments.new(data['attachments'])
      end

      def id
        data['id']
      end

      def text
        data['text']
      end

      def author_id
        data['author_id']
      end

      def conversation_id
        data['conversation_id']
      end

      def created_at
        data['created_at']
      end

      def reply_to
        in_reply_to_user_id
      end

      def in_reply_to_user_id
        data['in_reply_to_user_id']
      end

      def lang
        data['lang']
      end

      def nsfw?
        possibly_sensitive
      end

      def sensitive?
        possibly_sensitive
      end

      def possibly_sensitive
        data['possibly_sensitive']
      end

      def permission
        reply_settings
      end

      def reply_settings
        data['reply_settings']
      end

      def device
        source
      end

      def source
        data['source']
      end

      def withheld?
        withheld && !withheld.empty?
      end

      def withheld
        data['withheld']
      end

      def context_annotations
        @annotations.context_annotations || nil
      end

      def entity_annotations
        entities
      end

      def entities
        @annotations.entity_annotations || nil
      end
    end
  end
end
