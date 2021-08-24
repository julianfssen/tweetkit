require 'faraday'
require 'faraday_middleware'
require 'tweetkit/auth'

module Tweetkit
  module Connection
    include Tweetkit::Auth

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

      if method == :get
        conn = Faraday.new(params: data) do |c|
          if auth_type == 'oauth1'
            c.request :oauth, consumer_key: @consumer_key, consumer_secret: @consumer_secret
          else
            c.authorization :Bearer, @bearer_token
          end
        end
        response = conn.get(url)
      else
        conn = Faraday.new do |f|
        end
        response = conn.post(url)
      end
      conn.close
      Tweetkit::Response::Tweets.new response, twitter_request: { previous_url: @previous_url, previous_query: @previous_query }
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
      _fields = options.delete(:fields)
      if _fields && _fields.size > 0
        _fields.each do |key, value|
          if value.is_a?(Array)
            _value = value.join(',')
          else
            _value = value.delete(' ')
          end
          _key = key.to_s.gsub('_', '.')
          fields.merge!({ "#{_key}.fields" => _value })
        end
      end
      options.each do |key, value|
        if key.match?('_fields')
          if value.is_a?(Array)
            _value = value.join(',')
          else
            _value = value.delete(' ')
          end
          _key = key.to_s.gsub('_', '.')
          options.delete(key)
          fields.merge!({ _key => _value })
        end
      end
      fields
    end

    def build_expansions(options)
      expansions = {}
      _expansions = options.delete(:expansions)
      if _expansions && _expansions.size > 0
        _expansions = _expansions.join(',')
        expansions.merge!({ expansions: _expansions })
      end
      expansions
    end

    def parse_query_and_convenience_headers(options)
      options = options.dup
      fields = build_fields(options)
      options.merge!(fields)
      expansions = build_expansions(options)
      options.merge!(expansions)
      options
    end
  end
end
