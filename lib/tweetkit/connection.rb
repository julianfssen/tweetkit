require 'faraday'
require 'faraday_middleware'
require 'tweetkit/auth'
require 'tweetkit/response'

module Tweetkit
  module Connection
    include Tweetkit::Auth
    include Tweetkit::Response

    attr_accessor :previous_query, :previous_url

    BASE_URL = 'https://api.twitter.com/2/'

    def get(endpoint, **options)
      request :get, endpoint, parse_query_and_convenience_headers(options)
    end

    def post(endpoint, **options)
      request :post, endpoint, parse_query_and_convenience_headers(options)
    end

    def put(endpoint, **options)
      request :put, endpoint, parse_query_and_convenience_headers(options)
    end

    def delete(endpoint, **options)
      request :delete, endpoint, parse_query_and_convenience_headers(options)
    end

    def request(method, endpoint, data, **options)
      url = URI.parse("#{BASE_URL}#{endpoint}")
      @previous_url = url
      @previous_query = data

      connection = Faraday.new do |conn|
        if token_auth?
          conn.request :oauth, consumer_key: @consumer_key, consumer_secret: @consumer_secret,
                               token: @access_token, token_secret: @access_token_secret
        elsif bearer_auth?
          conn.request :authorization, 'Bearer', @bearer_token
        else
          raise NotImplementedError, 'No known authentication types were configured'
        end

        conn.request :json
        conn.response :json
      end

      response = case method
                 when :get
                   connection.get(url, data)
                 when :post
                   connection.post(url, data, 'Content-Type' => 'application/json')
                 when :put
                   connection.put(url, data, 'Content-Type' => 'application/json')
                 when :delete
                   connection.delete(url, data, 'Content-Type' => 'application/json')
                 end

      Tweetkit::Response::Tweets.new response, connection: connection, twitter_request: { previous_url: @previous_url, previous_query: @previous_query }
    rescue StandardError => e
      raise e
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
