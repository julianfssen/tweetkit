# frozen_string_literal: true

module Tweetkit
  module Default
    ENDPOINT = 'https://api.twitter.com/2/'

    class << self
      def options
        Hash[Tweetkit::Configurable.keys.map { |key| [key, send(key)] }]
      end

      def endpoint
        ENDPOINT
      end
    end
  end
end
