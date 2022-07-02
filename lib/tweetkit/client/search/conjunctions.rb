module Tweetkit
  class Client
    module Search
      # TODO: Document conjunctions
      module Conjunctions
        def contains(*terms)
          join(terms, connector: ' ')
        end
      
        def contains_one(*terms)
          contains_one_of(*terms)
        end
      
        def contains_one_of(*terms)
          join(terms, connector: ' OR ')
        end
      
        def without(*terms)
          does_not_contain(*terms)
        end
      
        def does_not_contain(*terms)
          join_with_negated_operator(terms)
        end
      
        def has(*terms)
          join_with_operator(terms, connector: ' ', operator: 'has')
        end
      
        def has_one(*terms)
          has_one_of(*terms)
        end
      
        def has_one_of(*terms)
          join_with_operator(terms, connector: ' OR ', operator: 'has')
        end
      
        def has_no(*terms)
          does_not_have(*terms)
        end
      
        def does_not_have(*terms)
          join_with_operator(terms, connector: ' ', operator: '-has')
        end
      
        def is_a(*terms)
          is(*terms)
        end
      
        def is(*terms)
          join_with_operator(terms, connector: ' ', operator: 'is')
        end
      
        def is_one_of(*terms)
          join_with_operator(terms, connector: ' OR ', operator: 'is')
        end
      
        def is_not(*terms)
          join_with_operator(terms, connector: ' ', operator: '-is')
        end
      
        def from(*terms)
          join_with_operator(terms, connector: ' ', operator: 'from')
        end
      
        def from_one(*terms)
          from_one_of(*terms)
        end
      
        def from_one_of(*terms)
          join_with_operator(terms, connector: ' OR ', operator: 'from')
        end
      
        def not_from(*terms)
          is_not_from(*terms)
        end
      
        def is_not_from(*terms)
          join_with_operator(terms, connector: ' ', operator: '-from')
        end
      
        def to(*terms)
          join_with_operator(terms, connector: ' ', operator: 'to')
        end
      
        def to_one_of(*terms)
          join_with_operator(terms, connector: ' OR ', operator: 'to')
        end
      
        def not_to(*terms)
          is_not_to(*terms)
        end
      
        def is_not_to(*terms)
          join_with_operator(terms, connector: ' ', operator: '-to')
        end
      
        def with_link(term)
          with_url(term)
        end
      
        def with_url(term)
          return "url:#{term}"
        end
      
        def with_links(*terms)
          with_urls(*terms)
        end
      
        def with_urls(*terms)
          join_with_operator(terms, connector: ' ', operator: 'url')
        end
      
        def with_one_of_links(*terms)
          with_one_of_urls(*terms)
        end
      
        def with_one_of_urls(*terms)
          join_with_operator(terms, connector: ' OR ', operator: 'url')
        end
      
        def without_link(term)
          without_url(term)
        end
      
        def without_url(term)
          return "-url:#{term}"
        end
      
        def without_links(*terms)
          join_with_operator(terms, connector: ' ', operator: '-url')
        end
      
        def retweets_of(*terms)
          join_with_operator(terms, connector: ' ', operator: 'retweets_of')
        end
      
        def retweets_of_one_of(*terms)
          join_with_operator(terms, connector: ' OR ', operator: 'retweets_of')
        end
      
        def not_retweets_of(*terms)
          are_not_retweets_of(*terms)
        end
      
        def are_not_retweets_of(*terms)
          join_with_operator(terms, connector: ' ', operator: '-retweets_of')
        end
      
        def with_context(*terms)
          context(*terms)
        end
      
        def context(*terms)
          join_with_operator(terms, connector: ' ', operator: 'context')
        end
      
        def with_one_of_context(*terms)
          one_of_context(*terms)
        end
      
        def one_of_context(*terms)
          join_with_operator(terms, connector: ' OR ', operator: 'context')
        end
      
        def without_context(*terms)
          not_with_context(*terms)
        end
      
        def not_with_context(*terms)
          join_with_operator(terms, connector: ' ', operator: '-context')
        end
      
        def with_entity(*terms)
          entities(*terms)
        end
      
        def with_entities(*terms)
          entities(*terms)
        end
      
        def entity(*terms)
          entities(*terms)
        end
      
        def entities(*terms)
          join_with_operator(terms, connector: ' ', operator: 'entity')
        end
      
        def with_one_of_entity(*terms)
          with_one_of_entities(*terms)
        end
      
        def with_one_of_entities(*terms)
          join_with_operator(terms, connector: ' OR ', operator: 'entity')
        end
      
        def without_entity(*terms)
          not_with_entities(*terms)
        end
      
        def without_entities(*terms)
          not_with_entities(*terms)
        end
      
        def not_with_entity(*terms)
          not_with_entities(*terms)
        end
      
        def not_with_entities(*terms)
          join_with_operator(terms, connector: ' ', operator: '-entity')
        end
      
        def with_conversation_id(*terms)
          conversation_ids(*terms)
        end
      
        def with_conversation_ids(*terms)
          conversation_ids(*terms)
        end
      
        def conversation_id(*terms)
          conversation_ids(*terms)
        end
      
        def conversation_ids(*terms)
          join_with_operator(terms, connector: ' ', operator: 'conversation_id')
        end
      
        def with_one_of_conversation_id(*terms)
          with_one_of_conversation_ids(*terms)
        end
      
        def with_one_of_conversation_ids(*terms)
          join_with_operator(terms, connector: ' OR ', operator: 'conversation_id')
        end
      
        def without_conversation_id(*terms)
          without_conversation_ids(*terms)
        end
      
        def without_conversation_ids(*terms)
          join_with_operator(terms, connector: ' ', operator: '-conversation_id')
        end
      
        def location(*terms)
          from_places(*terms)
        end
      
        def locations(*terms)
          from_places(*terms)
        end
      
        def place(*terms)
          from_places(*terms)
        end
      
        def places(*terms)
          from_places(*terms)
        end
      
        def from_location(*terms)
          from_places(*terms)
        end
      
        def from_locations(*terms)
          from_places(*terms)
        end
      
        def from_place(*terms)
          from_places(*terms)
        end
      
        def from_places(*terms)
          join_with_operator(terms, connector: ' ', operator: 'place')
        end
      
        def from_one_of_location(*terms)
          from_one_of_places(*terms)
        end
      
        def from_one_of_locations(*terms)
          from_one_of_places(*terms)
        end
      
        def from_one_of_place(*terms)
          from_one_of_places(*terms)
        end
      
        def from_one_of_places(*terms)
          join_with_operator(terms, connector: ' OR ', operator: 'place')
        end
      
        def not_from_location(*terms)
          not_from_places(*terms)
        end
      
        def not_from_place(*terms)
          not_from_places(*terms)
        end
      
        def not_from_locations(*terms)
          not_from_places(*terms)
        end
      
        def not_from_places(*terms)
          join_with_operator(terms, connector: ' ', operator: '-place')
        end
      
        def country(*terms)
          from_countries(*terms)
        end
        
        def countries(*terms)
          from_countries(*terms)
        end
      
        def from_country(*terms)
          from_countries(*terms)
        end
      
        def from_countries(*terms)
          join_with_operator(terms, connector: ' ', operator: 'place_country')
        end
      
        def from_one_of_country(*terms)
          from_one_of_countries(*terms)
        end
      
        def from_one_of_countries(*terms)
          join_with_operator(terms, connector: ' OR ', operator: 'place_country')
        end
      
        def not_from_country(*terms)
          not_from_countries(*terms)
        end
      
        def not_from_countries(*terms)
          join_with_operator(terms, connector: ' ', operator: '-place_country')
        end
      
        def lang(*terms)
          language(*terms)
        end
      
        def language(*terms)
          join_with_operator(terms, connector: ' ', operator: 'lang')
        end
      
        def not_lang(*terms)
          not_language(*terms)
        end
      
        def not_language(*terms)
          join_with_operator(terms, connector: ' ', operator: '-lang')
        end
      
        private
      
        def join(terms, connector:, **opts)
          unless terms.empty?
            terms = terms.collect do |term|
              term = term.to_s
              term = term.strip
              if term.split.length > 1
                "\"#{term}\""
              else
                term
              end
            end
            terms = terms.join(connector)
            append_to_query(terms)
            terms
          end
        end
      
        def join_with_operator(terms, connector:, operator:, **opts)
          unless terms.empty?
            terms = terms.collect do |term|
              term = term.to_s
              term = term.strip
              if term.split.length > 1
                "\"#{term}\""
              else
                term
              end
            end
            terms = terms.collect { |term| "#{operator}:#{term}" }
            terms = terms.join(connector)
            append_to_query(terms)
            terms
          end
        end
      
        def join_with_negated_operator(terms, **opts)
          unless terms.empty?
            terms = terms.collect do |term|
              term = term.to_s
              term = term.strip
              if term.split.length > 1
                "\"#{term}\""
              else
                term
              end
            end
            terms = terms.collect { |term| "-#{term}" }
            terms = terms.join(' ')
            append_to_query(terms)
            terms
          end
        end
      
        def append_to_query(term)
          if @query
            @query += " #{term}"
          else
            @query = term
          end
        end
      
        def group(&block)
          klass = Class.new(SearchFactory) do
            def join(terms, connector:, **opts)
              unless terms.empty?
                terms = terms.collect do |term|
                  term = term.to_s
                  term = term.strip
                  if term.split.length > 1
                    "\"#{term}\""
                  else
                    term
                  end
                end
                terms = terms.join(connector)
                group_terms(terms)
              end
            end
      
            def join_with_operator(terms, connector:, operator:, **opts)
              unless terms.empty?
                terms = terms.collect do |term|
                  term = term.to_s
                  term = term.strip
                  if term.split.length > 1
                    "\"#{term}\""
                  else
                    term
                  end
                end
                terms = terms.collect { |term| "#{operator}:#{term}" }
                terms = terms.join(connector)
                group_terms(terms)
              end
            end
      
            def join_with_negated_operator(terms, **opts)
              unless terms.empty?
                terms = terms.collect do |term|
                  term = term.to_s
                  term = term.strip
                  if term.split.length > 1
                    "\"#{term}\""
                  else
                    term
                  end
                end
                terms = terms.collect { |term| "-#{term}" }
                terms = terms.join(' ')
                group_terms(terms)
              end
            end
      
            def group_terms(term)
              if @grouped_terms
                @grouped_terms << term
              else
                @grouped_terms = []
                @grouped_terms << term
              end
            end
      
            def combine_terms
              @combined_grouped_terms = @grouped_terms.join(' ')
              @combined_grouped_terms = "(#{@combined_grouped_terms})"
              append_to_query(@combined_grouped_terms)
              @combined_grouped_terms
            end
          end

          klass.new.yield_self do |search_factory|
            search_factory.instance_eval(&block)
            search_factory.combine_terms
          end
        end
      end
    end
  end
end

