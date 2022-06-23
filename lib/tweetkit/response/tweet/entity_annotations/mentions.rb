module Tweetkit
  class Response
    class Tweet
      class EntityAnnotations
        # Contains details about text recognized as a user mention.
        class Mentions
          include Enumerable

          attr_accessor :mentions

          def initialize(mentions)
            @mentions = mentions.collect { |mention| Mention.new(mention) }
          end

          def each(*args, &block)
            @mentions.each(*args, &block)
          end

          class Mention
            attr_accessor :mention

            def initialize(mention)
              @mention = mention
            end

            # The start position (zero-based) of the recognized Mention within the Tweet. All start indices are inclusive.
            #
            # @return [Integer]
            def start
              mention["start"]
            end

            # The end position (zero-based) of the recognized Mention within the Tweet. This end index is exclusive.
            #
            # @return [Integer]
            def finish
              mention["end"]
            end

            # The text of the Mention.
            #
            # @return [String]
            def username
              mention["tag"]
            end

            alias_method :end, :finish
          end
        end
      end
    end
  end
end
