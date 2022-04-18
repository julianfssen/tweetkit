# frozen_string_literal: true

module Tweetkit
  class Response
    def initialize(response, **options)
      @response = response.body
      # @connection = options[:connection]
      # @prev_request = options[:prev_request]

      build_resource(@response)
    end

    def build_resource(response)
    end

    # def next_page
    #   @connection.params.merge!({ next_token: @response.meta.next_token })
    #   response = @connection.get(@prev_request[:endpoint])

    #   new(response, connection: @connection, prev_request: { endpoint:, data: })
    # end

    # def prev_page
    #   @connection.params.merge!({ previous: @response.meta.previous_token })
    #   response = @connection.get(@prev_request[:endpoint])

    #   new(response, connection: @connection, prev_request: { endpoint:, data: })
    # end
  end
end
