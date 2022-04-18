module Tweetkit
  class Client
    include Base
    include Connection

    attr_accessor :access_token, :access_token_secret, :bearer_token, :consumer_key, :consumer_secret

    def initialize(**opts)
      opts.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end

      yield self if block_given?

      set_defaults
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
  end
end
