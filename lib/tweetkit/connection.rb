require 'faraday'
require 'faraday_middleware'
require 'tweetkit/auth'
require 'tweetkit/response'
require 'pry'

module Tweetkit
  module Connection
    include Tweetkit::Auth
    include Tweetkit::Response

    attr_accessor :previous_query, :previous_url

    BASE_URL = 'https://api.twitter.com/2/'

    def get(endpoint, **options)
      request :get, endpoint, parse_query_and_convenience_headers(options)
    end

    def request(method, endpoint, data, **options)
      auth_type = options.delete(:auth_type)
      url = URI.parse("#{BASE_URL}#{endpoint}")
      @previous_url = url
      @previous_query = data

      # if method == :get
      #   connection = Faraday.new(params: data) do |conn|
      #     if auth_type == 'oauth1'
      #       conn.request :oauth, consumer_key: @consumer_key, consumer_secret: @consumer_secret
      #     else
      #       conn.authorization :Bearer, @bearer_token
      #     end
      #   end
      #   response = connection.get(url)
      # else
      #   connection = Faraday.new do |f|
      #   end
      #   response = connection.post(url)
      # end
      # Tweetkit::Response::Tweets.new response, connection: connection, twitter_request: { previous_url: @previous_url, previous_query: @previous_query }
    rescue StandardError => e
      raise e
    end

    def auth_token(type = 'bearer')
      case type
      when 'bearer'
        @bearer_token
      end
    end

    def build_fields(options)
      fields = {}
      fields_ = options.delete(:fields)

      if fields_ && !fields_.empty?
        fields_.each do |field, value|
          if value.is_a? Array
            value = value.join(',')
          else
            value = value.delete(' ')
          end

          field = field.to_s.gsub('_', '.')
          fields.merge!({ "#{field}.fields" => value })
        end
      end

      options.each do |key, value|
        next unless key.match? '_fields'

        options.delete(key)

        if value.is_a? Array
          value = value.join(',')
        else
          value = value.delete(' ')
        end

        key = key.to_s.gsub('_', '.')
        fields.merge!({ key => value })
      end

      fields
    end

    def build_expansions(options)
      expansions = options.delete(:expansions)
      return unless expansions

      expansions = expansions.join(',') if expansions.is_a? Array
      binding.pry
      { expansions: expansions }
    end

    def parse_query_and_convenience_headers(options)
      options = options.dup
      fields = build_fields(options)
      options.merge!(fields) if fields
      expansions = build_expansions(options)
      options.merge!(expansions) if expansions
      options
    end
  end
end
