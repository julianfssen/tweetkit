module Tweetkit::Response::Tweet::Annotations::Entity
  class Urls
    attr_accessor :urls

    def initialize(urls)
      return unless urls

      @urls = urls.collect { |url| Url.new(url) }
    end

    class Url
      attr_accessor :description, :display_url, :end, :expanded_url, :start, :status, :title, :url, :unwound_url

      def initialize(url)
        @description = url['description']
        @display_url = url['display_url']
        @end = url['end']
        @expanded_url = url['expanded_url']
        @start = url['start']
        @status = url['status']
        @title = url['title']
        @url = url['url']
        @unwound_url = url['unwound_url']
      end
    end
  end
end
