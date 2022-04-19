module Tweetkit
  # Client for the Twitter v2 API
  #
  # @see https://developer.twitter.com/en/docs/twitter-api
  class Client
    include Base
    include Connection

    attr_accessor :access_token, :access_token_secret, :bearer_token, :consumer_key, :consumer_secret

    # Creates a new instance of +Tweetkit::Client+
    # @param [Hash] opts The options to create the client with
    #
    # @option opts [String] :access_token The access token (known as the +Access Token+ in the developer portal) used to authenticate OAuth 1.0a requests. More info: https://developer.twitter.com/en/docs/authentication/oauth-1-0a/obtaining-user-access-tokens
    # @option opts [String] :access_token_secret The access token secret (known as the +Access Token Secret+ in the developer portal) used to authenticate OAuth 1.0a requests. More info: https://developer.twitter.com/en/docs/authentication/oauth-1-0a/obtaining-user-access-tokens
    # @option opts [String] :bearer_token The token (known as the +Bearer Token+ in the developer portal) used to authenticate OAuth 2.0 requests. More info: https://developer.twitter.com/en/docs/authentication/oauth-2-0/application-only
    # @option opts [String] :consumer_key The consumer key (known as the +API Key+ in the developer portal) used to authenticate OAuth 1.0a requests. More info: https://developer.twitter.com/en/docs/authentication/oauth-1-0a/api-key-and-secret
    # @option opts [String] :consumer_secret The consumer secret (known as the +API Secret+ in the developer portal) used to authenticate OAuth 1.0a requests. More info: https://developer.twitter.com/en/docs/authentication/oauth-1-0a/api-key-and-secret
    #
    # @example Initializing the client
    #   # Initializing via options
    #   client = Tweetkit::Client.new(bearer_token: "YOUR_BEARER_TOKEN_HERE")
    # 
    #   # Initializing with a block
    #   client = Tweetkit::Client.new do |config|
    #     config.bearer_token = "YOUR_BEARER_TOKEN_HERE"
    #   end
    #
    # @return [Tweetkit::Client] An instance of Tweetkit::Client

    def initialize(**opts)
      opts.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end

      yield self if block_given?

      set_defaults
      run_initializers
    end

    private

    def auth_options
      @auth_options ||= [:access_token, :access_token_secret, :bearer_token, :consumer_key, :consumer_secret]
    end

    def set_defaults
      auth_options.each do |key|
        if instance_variable_get(:"@#{key}").nil?
          instance_variable_set(:"@#{key}", ENV["#{key.upcase}"])
        end
      end
    end

    def run_initializers
      Tweetkit::Initializers.constants.each do |initializer|
        Object.const_get("Tweetkit::Initializers::#{initializer.to_s}").run
      end
    end
  end
end
