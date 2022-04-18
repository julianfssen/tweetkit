# require "faraday"
# require "faraday_middleware"

module Tweetkit
  module Connection
    # include Pagination

    BASE_URL = "https://api.twitter.com/2/".freeze

    def get(endpoint, **options)
      request :get, endpoint, parse_options(options)
    end

    def post(endpoint, **options)
      request :post, endpoint, parse_options(options)
    end

    def put(endpoint, **options)
      request :put, endpoint, parse_options(options)
    end

    def delete(endpoint, **options)
      request :delete, endpoint, parse_options(options)
    end

    def request(method, endpoint, data, **options)
      connection = Faraday.new do |conn|
        conn.url BASE_URL

        if token_auth?
          conn.request :oauth,
                       consumer_key: @consumer_key,
                       consumer_secret: @consumer_secret,
                       token: @access_token,
                       token_secret: @access_token_secret
        elsif bearer_auth?
          conn.request :authorization, "Bearer", @bearer_token
        else
          raise NotImplementedError, "No known authentication types were configured"
        end

        conn.request :json
        conn.response :json
      end

      response = case method
                 when :get
                   connection.get(endpoint, data)
                 when :post
                   connection.post(endpoint, data)
                 when :put
                   connection.put(endpoint, data)
                 when :delete
                   connection.delete(endpoint, data)
                 end

      Tweetkit::Response.new(response)
    rescue StandardError => e
      raise e
    end

    private

    def build_fields(options)
      fields = {}
      fields_ = options.delete(:fields)

      if fields_ && !fields_.empty?
        fields_.each do |field, value|
          if value.is_a? Array
            value = value.join(",")
          else
            value = value.delete(" ")
          end

          field = field.to_s.gsub("_", ".")
          fields.merge!({ "#{field}.fields" => value })
        end
      end

      options.each do |key, value|
        next unless key.match? "_fields"

        options.delete(key)

        if value.is_a? Array
          value = value.join(",")
        else
          value = value.delete(" ")
        end

        key = key.to_s.gsub("_", ".")
        fields.merge!({ key => value })
      end

      fields
    end

    def build_expansions(options)
      expansions = options.delete(:expansions)
      return unless expansions

      expansions = expansions.join(",") if expansions.is_a? Array
      { expansions: expansions }
    end

    def parse_options(options)
      options = options.dup

      fields = build_fields(options)
      options.merge!(fields) if fields

      expansions = build_expansions(options)
      options.merge!(expansions) if expansions

      options
    end
  end
end
