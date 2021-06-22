require 'tweetkit/client'

module Tweetkit
  class << self
    def client
      return @client if defined?(@client) && @client.same_options?(options)

      @client = Tweetkit::Client.new(options)
    end
  end
end
