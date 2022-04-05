# frozen_string_literal: true

require 'json'

module Tweetkit
  module Response
    class Tweets
      include Enumerable

      attr_accessor :annotations, :connection, :context_annotations, :entity_annotations, :expansions, :fields, :meta, :options, :original_response, :response, :tweets, :twitter_request

      def initialize(response, **options)
        parse! response, **options
      end

      def parse!(response, **options)
        parse_response response
        extract_and_save_tweets
        return unless @tweets

        extract_and_save_meta
        extract_and_save_expansions
        extract_and_save_options(**options)
        extract_and_save_request
      end

      def parse_response(response)
        @response = response.body
      end

      def extract_and_save_tweets
        if (data = @response['data'])
          if data.is_a?(Array)
            @tweets = @response['data'].collect { |tweet| Tweet.new(tweet) }
          else
            @tweets = [Tweet.new(@response['data'])]
          end
        else
          @tweets = nil
        end
      end

      def extract_and_save_meta
        @meta = Meta.new(@response['meta'])
      end

      def extract_and_save_expansions
        @expansions = Expansions.new(@response['includes'])
      end

      def extract_and_save_options(**options)
        @options = options
      end

      def extract_and_save_request
        @connection = @options[:connection]
        @twitter_request = @options[:twitter_request]
      end

      def each(*args, &block)
        tweets.each(*args, &block)
      end

      def last
        tweets.last
      end

      def tweet
        tweets.first
      end

      def next_page
        connection.params.merge!({ next_token: meta.next_token })
        response = connection.get(twitter_request[:previous_url])
        parse! response,
               connection: connection,
               twitter_request: {
                 previous_url: twitter_request[:previous_url],
                 previous_query: twitter_request[:previous_query]
               }
        self
      end

      def prev_page
        connection.params.merge!({ previous: meta.previous_token })
        response = connection.get(twitter_request[:previous_url])
        parse! response,
               connection: connection,
               twitter_request: {
                 previous_url: twitter_request[:previous_url],
                 previous_query: twitter_request[:previous_query]
               }
        self
      end
    end
  end
end
