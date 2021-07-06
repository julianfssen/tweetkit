require 'pry'
require 'faraday'
require 'tweetkit/auth'
require 'tweetkit/default'
require 'tweetkit/response'

module Tweetkit
  module Connection
    include Tweetkit::Auth

    BASE_URL = 'https://api.twitter.com/2/'

    def get(endpoint, **options)
      request :get, endpoint, parse_query_and_convenience_headers(options)
    end

    def request(method, endpoint, data, **options)
      headers = data.delete(:headers)
      url = URI.parse("#{BASE_URL}#{endpoint}")

      if method == :get
        response = Faraday.get(url, data, headers)
      else
        response = Faraday.post(url, data, headers)
      end
      Tweetkit::Response.new(response)
    rescue StandardError => e
      raise e
    end

    def auth_headers(type = 'bearer')
      case type
      when 'bearer'
        { 'Authorization': "Bearer #{@bearer_token}" }
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
      options[:headers] = auth_headers
      fields = build_fields(options)
      options.merge!(fields)
      expansions = build_expansions(options)
      options.merge!(expansions)
      options
    end
  end
end
