require 'faraday'
require 'tweetkit/auth'
require 'tweetkit/default'

module Tweetkit
  module Connection
    include Tweetkit::Auth

    CONVENIENCE_HEADERS = Set.new([:accept, :content_type])

    def get(url, **options)
      request :get, url, parse_query_and_convenience_headers(options)
    end

    def request(method, path, data, options = {})
      if data.is_a?(Hash)
        options[:query]   = data.delete(:query) || {}
        options[:headers] = data.delete(:headers) || {}
        if accept = data.delete(:accept)
          options[:headers][:accept] = accept
        end
      end

      options = options[:headers].merge(oauth_headers)

      url = URI.parse(Tweetkit::Default.endpoint + path)

      if method == :get
        response = Faraday.get(url, data, options)
      else
        response = Faraday.post(url, data, options)
      end
      pp response
      response.body
    rescue StandardError => e
      raise e
    end

    def oauth_headers
      if bearer_auth?
        { 'Authorization': "Bearer #{@bearer_token}" }
      end
    end

    def build_fields(options)
      fields = {}
      _fields = options.delete(:fields)
      if _fields.size > 0
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
      if _expansions.size > 0
        _expansions.each do |key, value|
          if value.is_a?(Array)
            _value = value.join(',')
          else
            _value = value.delete(' ')
          end
          _key = key.to_s.gsub('_', '.')
          expansions.merge!({ "#{_key}.fields" => _value })
        end
      end
      expansions
    end

    def parse_query_and_convenience_headers(options)
      options = options.dup
      headers = options.delete(:headers) { Hash.new }
      CONVENIENCE_HEADERS.each do |h|
        if header = options.delete(h)
          headers[h] = header
        end
      end
      fields = build_fields(options)
      opts = options.merge!(fields)
      # query = options.delete(:query)
      # opts = {:query => options}
      # opts[:query].merge!(query) if query && query.is_a?(Hash)
      opts[:headers] = headers unless headers.empty?

      opts
    end
  end
end
