# frozen_string_literal: true

module Tweetkit
  class Search
    attr_writer :query

    def initialize
      @query = ''
    end

    def connectors
      @connectors ||= { connectors: [] }
    end

    def query(query)
      @query = query
      self
    end

    def has(term)
      add_connector(:has, term)
      self
    end

    def and(term)
      add_connector(:and, term)
      self
    end

    def or(term)
      add_connector(:or, term)
      self
    end

    def add_connector(connector, term)
      connectors[:connectors] = connectors[:connectors].push({ connector => term })
    end
  end
end
