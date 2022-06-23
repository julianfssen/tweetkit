module Tweetkit
  class Response
    class Tweet
      class EntityAnnotations
        # Contains details about text recognized as a URL.
        class Urls
          include Enumerable

          attr_accessor :urls

          def initialize(urls)
            @urls = urls.collect { |url| Url.new(url) }
          end

          def each(*args, &block)
            @urls.each(*args, &block)
          end

          class Url
            attr_accessor :url

            def initialize(url)
              @url = url
            end

            # The start position (zero-based) of the recognized URL within the Tweet. All start indices are inclusive.
            #
            # @return [Integer]
            def start
              url["start"]
            end

            # The end position (zero-based) of the recognized URL within the Tweet. This end index is exclusive.
            #
            # @return [Integer]
            def finish
              url["end"]
            end

            # The URL as displayed in the Twitter client.
            #
            # @return [String]
            def display_url
              url["display_url"]
            end

            # The fully resolved URL.
            #
            # @return [String]
            def expanded_url
              url["expanded_url"]
            end

            # The full destination URL.
            #
            # @return [String]
            def unwound_url
              url["unwound_url"]
            end

            alias_method :end, :finish
          end
        end
      end
    end
  end
end
