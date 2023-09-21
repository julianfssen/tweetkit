require 'tweetkit/connection'
require 'tweetkit/client/tweets'
require 'tweetkit/client/users'

module Tweetkit
  class Client
    include Tweetkit::Connection
    include Tweetkit::Client::Tweets
    include Tweetkit::Client::Users

    attr_accessor :access_token, :access_token_secret, :bearer_token, :consumer_key, :consumer_secret, :email, :password

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end
      yield self if block_given?
    end
  end
end
