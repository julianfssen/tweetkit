require "faraday"

module Tweetkit
  # Module for creating and authenticating requests to Twitter API v2 endpoints
  module Connection
    include Auth

    BASE_URL = "https://api.twitter.com/2/".freeze

    # Performs a GET request for the specified endpoint
    #
    # @param endpoint [String] The API endpoint to fetch, relative to {#Tweetkit::Connection::BASE_URL}
    # @param options [Hash] Body and header params for the request
    #
    # @return [Tweetkit::Response] Returns a {#Tweetkit::Response} object based on the specified endpoint
    def get(endpoint, **options)
      request :get, endpoint, parse_options(options)
    end

    # Performs a POST request for the specified endpoint
    #
    # @param endpoint [String] The API endpoint to post to, relative to {#Tweetkit::Connection::BASE_URL}
    # @param options [Hash] Body and header params for the request
    #
    # @return [Tweetkit::Response] Returns a {#Tweetkit::Response} object based on the specified endpoint
    def post(endpoint, **options)
      request :post, endpoint, parse_options(options)
    end

    # Performs a PUT request for the specified endpoint
    #
    # @param endpoint [String] The API endpoint to post to, relative to {#Tweetkit::Connection::BASE_URL}
    # @param options [Hash] Body and header params for the request
    #
    # @return [Tweetkit::Response] Returns a {#Tweetkit::Response} object based on the specified endpoint
    def put(endpoint, **options)
      request :put, endpoint, parse_options(options)
    end

    # Performs a DELETE request for the specified endpoint
    #
    # @param endpoint [String] The API endpoint to delete to, relative to {#Tweetkit::Connection::BASE_URL}
    # @param options [Hash] Body and header params for the request
    #
    # @return [Tweetkit::Response] Returns a {#Tweetkit::Response} object based on the specified endpoint
    def delete(endpoint, **options)
      request :delete, endpoint, parse_options(options)
    end

    private

    # Creates a HTTP request to interact with the Twitter v2 API endpoints
    #
    # @param method [Symbol] The HTTP method to perform
    # @param endpoint [String] The API endpoint to perform the request, relative to {#Tweetkit::Connection::BASE_URL}
    # @param data [Hash] Body and header params for the request
    # @param options [Hash] Additional options to create the request
    #
    # @return [Tweetkit::Response] Returns a +Tweetkit::Response+ object based on the specified endpoint
    def request(method, endpoint, data, **options)
      connection = Faraday.new(BASE_URL) do |conn|
        conn.request :json
        conn.response :json

        if token_auth? && method != :get
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

        conn.use Faraday::Response::RaiseError
        conn.adapter Faraday.default_adapter
      end

      resource = data.delete(:resource)

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

      Tweetkit::Response.build_resource(response, resource: resource, method: method)
    rescue Faraday::Error => error
      message = format_error_message(error)

      if error.kind_of? Faraday::ClientError
        raise Tweetkit::Error::ClientError.new(message)
      elsif error.kind_of? Faraday::ServerError
        raise Tweetkit::Error::ServerError.new(message)
      else
        raise error
      end
    end

    # Extracts the list of Twitter request fields to pass
    # @see https://developer.twitter.com/en/docs/twitter-api/fields
    #
    # @param options [Hash] Options from the request's body params
    #
    # @return [Hash] A hash of formatted Twitter v2 API fields to pass to the request
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

    # Extracts the list of Twitter request expansions to pass
    # @see https://developer.twitter.com/en/docs/twitter-api/expansions
    #
    # @param options [Hash] Options from the request's body params
    #
    # @return [Hash] A hash of formatted Twitter v2 API expansions to pass to the request
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

    # Creates a formatted error message from Twitter errors
    # 
    # @param error [StandardError] The error rescued from the request
    #
    # @return [String] A formatted error messages with data from the Twitter error
    def format_error_message(error)
      debugger
      error_obj = JSON.parse(error.response_body)

      <<-ERR
        Error: #{error_obj["title"]} (#{error_obj["status"]})
        Description: #{error_obj["detail"]}
        Info: #{error_obj["type"]}
      ERR
    end
  end
end
