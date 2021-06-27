# frozen_string_literal: true

module Tweetkit
  class Search
    attr_writer :query

    def initialize(query)
      @query = query
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

    def has_one_of(terms)
    end

    def contains(terms)
    end

    def contains_one_of(terms)
    end

    def without
    end

    def without_one_of
    end

    def and
      self
    end

    def or
      self
    end

    def or_one_of
    end

    def is
    end

    def is_one_of
    end

    def is_not
    end

    def from_country
    end

    def group
    end

    def add_connector(connector, term)
      connectors[:connectors] = connectors[:connectors].push({ connector => term })
    end

    def build_connector(connector, terms)
      query = ''
      if connector
        terms.each do |term|
          term = term.strip
          query << "#{connector}: #{term} "
        end
      else
        terms.each do |term|
          term = term.strip
          query << "#{term} "
        end
      end
      query.rstrip
    end

    def build_one_of_connector(connector, terms)
      query = []
      if connector.match?('contains')
        terms.each do |term|
          term = term.strip
          query << term
        end
      else
        terms.each do |term|
          term = term.strip
          query << "#{connector}: #{term}"
        end
      end
      query.join(' OR ')
    end

    def method_missing(connector, *terms)
      if connector.match?('one_of')
        build_one_of_connector(connector, terms)
      else
        build_connector(connector, terms)
      end
    end
  end
end
