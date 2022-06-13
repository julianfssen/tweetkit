module Tweetkit
  class Response
    class Tweet
      class EntityAnnotations
        # Contains details about text recognized as a user mention.
        class Mentions
          attr_accessor :mentions

          def initialize(mentions)
            return unless mentions

            @mentions = mentions.collect { |mention| Mention.new(mention) }
          end

          class Mention
            attr_accessor :mention

            alias_method :end, :finish

            def initialize(mention)
              @mention = mention
            end

            # The start position (zero-based) of the recognized Mention within the Tweet. All start indices are inclusive.
            def start
              mention["start"]
            end

            # The end position (zero-based) of the recognized Mention within the Tweet. This end index is exclusive.
            def finish
              mention["end"]
            end

            # The text of the Mention.
            def username
              mention["tag"]
            end
          end
        end
      end
    end
  end
end
