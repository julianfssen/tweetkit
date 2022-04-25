module Tweetkit
  class Response
    class Tweet
      class Annotations
        class Entity
          class Hashtags
            attr_accessor :hashtags

            def initialize(hashtags)
              return unless hashtags

              @hashtags = hashtags.collect { |hashtag| Hashtag.new(hashtag) }
            end

            class Hashtag
              attr_accessor :end, :start, :tag

              def initialize(hashtag)
                @end = hashtag["end"]
                @start = hashtag["start"]
                @tag = hashtag["tag"]
              end
            end
          end
        end
      end
    end
  end
end
