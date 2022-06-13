module Tweetkit
  class Response
    class Tweet
      class EntityAnnotations
        # Contains details about text recognized as a URL.
        class Urls
          attr_accessor :urls

          def initialize(urls)
            return unless urls

            @urls = urls.collect { |url| Url.new(url) }
          end

          class Url
            attr_accessor :url

            alias_method :end, :finish

            def initialize(url)
              @url = url
            end

            # The start position (zero-based) of the recognized URL within the Tweet. All start indices are inclusive.
            def start
              url["start"]
            end

            # The end position (zero-based) of the recognized URL within the Tweet. This end index is exclusive.
            def finish
              url["end"]
            end

            # The URL as displayed in the Twitter client.
            def display_url
              url["display_url"]
            end

            # The fully resolved URL.
            def expanded_url
              url["expanded_url"]
            end

            # The full destination URL.
            def unwound_url
              url["unwound_url"]
            end
          end
        end
      end
    end
  end
end
