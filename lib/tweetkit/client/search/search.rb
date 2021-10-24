# frozen_string_literal: true

require_relative 'conjunctions';

module Tweetkit
  class Search
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
end
