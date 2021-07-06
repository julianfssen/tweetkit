# frozen_string_literal: true

module Tweetkit
  module Default
    class << self
      def options
        Hash[Tweetkit::Configurable.keys.map { |key| [key, send(key)] }]
      end
    end
  end
end
