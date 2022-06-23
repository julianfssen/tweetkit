require "faraday"

module Tweetkit
  # Module for creating and authenticating requests to Twitter API v2 endpoints
  module Request
    include Auth
    include OptionsBuilder

    BASE_URL = "https://api.twitter.com/2/".freeze

    private

    # Performs a GET request for the specified endpoint
    #
    # @param endpoint [String] The API endpoint to fetch, relative to {#Tweetkit::Request::BASE_URL}
    # @param options [Hash] Body and header params for the request
    #
    # @return [Tweetkit::Response] Returns a {#Tweetkit::Response} object based on the specified endpoint
    def get(endpoint, **options)
      request :get, endpoint, build_request_options(options)
    end

    # Performs a POST request for the specified endpoint
    #
    # @param endpoint [String] The API endpoint to post to, relative to {#Tweetkit::Request::BASE_URL}
    # @param options [Hash] Body and header params for the request
    #
    # @return [Tweetkit::Response] Returns a {#Tweetkit::Response} object based on the specified endpoint
    def post(endpoint, **options)
      request :post, endpoint, build_request_options(options)
    end

    # Performs a PUT request for the specified endpoint
    #
    # @param endpoint [String] The API endpoint to post to, relative to {#Tweetkit::Request::BASE_URL}
    # @param options [Hash] Body and header params for the request
    #
    # @return [Tweetkit::Response] Returns a {#Tweetkit::Response} object based on the specified endpoint
    def put(endpoint, **options)
      request :put, endpoint, build_request_options(options)
    end

    # Performs a DELETE request for the specified endpoint
    #
    # @param endpoint [String] The API endpoint to delete to, relative to {#Tweetkit::Request::BASE_URL}
    # @param options [Hash] Body and header params for the request
    #
    # @return [Tweetkit::Response] Returns a {#Tweetkit::Response} object based on the specified endpoint
    def delete(endpoint, **options)
      request :delete, endpoint, build_request_options(options)
    end

    # Creates a HTTP request to interact with the Twitter v2 API endpoints
    #
    # @param method [Symbol] The HTTP method to perform
    # @param endpoint [String] The API endpoint to perform the request, relative to {#Tweetkit::Request::BASE_URL}
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

    # Creates a formatted error message from Twitter errors
    # 
    # @param error [StandardError] The error rescued from the request
    #
    # @return [String] A formatted error messages with data from the Twitter error
    def format_error_message(error)
      error_obj = JSON.parse(error.response_body)

      <<-ERR
        Error: #{error_obj.dig("title")} (#{error_obj.dig("status")})
        Description: #{error_obj.dig("detail")}
        Error Info: #{error_obj.dig("errors", 0, "message")}
        Error Link: #{error_obj.dig("type")}
      ERR
    end
  end
end
