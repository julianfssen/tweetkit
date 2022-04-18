module Tweetkit
  class Client
    module Search
      class Searcher
        include Conjunctions

        attr_accessor :current_query

        def initialize(term)
          @current_query = term
        end

        def opts
          @opts ||= {}
        end

        def evaluate(&block)
          instance_eval(&block)
        end
      end

      def search(query = "", type: :tweet, **options, &block)
        search = Searcher.new(query)
        search.evaluate(&block) if block_given?
        get("tweets/search/recent", **options.merge!({ query: search.current_query }))
      end
    end
  end
end
