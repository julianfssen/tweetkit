module Tweetkit
  module Configurable
    def self.keys
      @keys ||= %i[
        access_token
        access_token_secret
        bearer_token
        consumer_key
        consumer_secret
        password
        email
      ]
    end

    private

    def options
      Hash[Tweetkit::Configurable.keys.map { |key| [key, instance_variable_get(:"@#{key}")] }]
    end
  end
end
