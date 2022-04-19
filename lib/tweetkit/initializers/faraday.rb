require "faraday"

module Tweetkit
  module Initializers
    class Faraday
      def self.run
        ::Faraday::Request.register_middleware(oauth: -> { Tweetkit::FaradayMiddleware::OAuth })
      end
    end
  end
end
