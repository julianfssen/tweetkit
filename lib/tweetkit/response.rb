# frozen_string_literal: true

module Tweetkit
  # Class for creating a response object from the resources returned by the Twitter v2 API
  class Response
    RESOURCE_CLASS_MAP = {
      tweet: "Tweetkit::Response::Tweet",
      tweets: "Tweetkit::Response::Tweets"
    }.freeze

    class << self
      def build_resource(response, **options)
        if options[:method] == :delete
          tweet_deleted?(response)
        else
          klass = Object.const_get(RESOURCE_CLASS_MAP[options[:resource]])
          klass.new(response.body)
        end
      end

      private

      def tweet_deleted?(response)
        response.body.dig("data", "deleted")
      end
    end
  end
end
