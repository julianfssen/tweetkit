module Tweetkit::Response::Tweet::Annotations::Entity
  class Mentions
    attr_accessor :mentions

    def initialize(mentions)
      return unless mentions

      @mentions = mentions.collect { |mention| Mention.new(mention) }
    end

    class Mention
      attr_accessor :end, :id, :start, :username

      def initialize(mention)
        @end = mention['end']
        @id = mention['id']
        @start = mention['start']
        @username = mention['username']
      end
    end
  end
end
