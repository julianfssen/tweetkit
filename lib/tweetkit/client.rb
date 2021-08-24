require 'tweetkit/configurable'
require 'tweetkit/default'
require 'tweetkit/response'
require 'tweetkit/client/tweets'

module Tweetkit
  class Client
    include Tweetkit::Response
    include Tweetkit::Client::Tweets

    attr_accessor :access_token, :access_token_secret, :bearer_token, :consumer_key, :consumer_secret, :email, :password

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end
      yield self if block_given?
    end
  end
end
