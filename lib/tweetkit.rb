require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module Tweetkit
  class << self
    def client
      return @client if defined?(@client)

      @client = Tweetkit::Client.new(options)
    end
  end
end
