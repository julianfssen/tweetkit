require 'tweetkit/configurable'
require 'tweetkit/connection'
require 'tweetkit/client/tweets'

module Tweetkit
  class Client
    include Tweetkit::Connection
    include Tweetkit::Client::Tweets

    attr_accessor :access_token, :access_token_secret, :bearer_token, :consumer_key, :consumer_token, :email, :password

    def initialize(options = {})
      Tweetkit::Configurable.keys.each do |key|
        if options.key?(key)
          value = options[key]
        else
          Tweetkit.instance_variable_get(:"@#{key}")
        end
        instance_variable_set(:"@#{key}", value)
      end
    end
  end
end
