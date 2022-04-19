require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

# Ruby wrapper for Twitter's v2 API
module Tweetkit
  class << self
    # Returns the current +Tweetkit::Client+ instance or a newly-created instance if there is no existing client instance.
    #
    # @return [Tweetkit::Client] The current client or a newly-created instance
    def client
      return @client if defined?(@client)

      @client = Tweetkit::Client.new
    end
  end
end
