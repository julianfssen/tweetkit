module Tweetkit
  class Client
    # The +Search+ module implements +tweetkit+'s search DSL, which enables powerful and flexible
    # search requests when interacting with Twitter's v2 API.
    #
    # This module includes the +Conjunctions+ mixin, which are methods that enable search queries
    # to be built in natural language.
    #
    # @note The search methods are designed to use similar APIs to Twitter's query operators: https://developer.twitter.com/en/docs/twitter-api/tweets/search/integrate/build-a-query
    #
    # @example Example query:
    #   # Searches for retweets in the last 7 days that contains the word "elon" and "tesla" 
    #   # and is not from the "@bbc" Twitter account.
    #
    #   client.search do
    #     is :retweet
    #     contains 'elon', 'tesla'
    #     not_from '@bbc'
    #   end
    #
    # If you want to use Twitter's query operators directly, you can pass a string to the +query+ argument.
    #
    # @example Directly passing the query to the endpoint:
    #   client.search('manutd is:retweet ronaldo "ten hag" has:media OR has:link -from:ManUtd')
    #
    # Read more on how Twitter's query operators work here: https://developer.twitter.com/en/docs/twitter-api/tweets/search/integrate/build-a-query
    module Search
      # Class responsible for +tweetkit+'s search logic
      class SearchFactory
        include Conjunctions

        attr_accessor :query

        def initialize(term = "")
          @query = term
        end

        def opts
          @opts ||= {}
        end

        def evaluate(&block)
          instance_eval(&block)
        end
      end

      # Searches Tweets from the last 7 days with the given query and options.
      #
      # @see See Module::Conjunctions for the list of operators available for searching.
      #
      # @param [String] query The Twitter query to fetch. Not required when passing a block.
      # @param [Symbol] type The type of Twitter resource to search.
      #
      # @option options [String] TODO
      #
      # @return [Tweetkit::Response::Tweets] An instance of +Tweetkit::Response::Tweets+ based on the search results.
      #
      # @example Searching by passing in a block:
      #   client.search do
      #     is :retweet
      #     contains "elon", "tesla"
      #     not_from "@bbc"
      #   end
      #
      # @example Searching by passing in a Twitter query:
      #   client.search('manutd is:retweet ronaldo "ten hag" has:media OR has:link -from:ManUtd')
      def search(query = "", type: :tweet, **options, &block)
        search = SearchFactory.new(query)
        search.evaluate(&block) if block_given?
        get("tweets/search/recent", resource: :tweets, **options.merge!({ query: search.query }))
      end
    end
  end
end
