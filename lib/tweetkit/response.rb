require 'json'

module Tweetkit
  class Response
    attr_accessor :expansions, :meta, :original_response, :tweets

    def initialize(response)
      @original_response = response.body
      parsed_response = JSON.parse(@original_response)
      @tweets = Tweetkit::Response::Tweets.new(parsed_response)
      @meta = Tweetkit::Response::Meta.new(@tweets.meta)
      @expansions = Tweetkit::Response::Expansions.new(@tweets.expansions)
    end

    class Expansions
      include Enumerable

      attr_accessor :expansions

      def initialize(expansions)
        @expansions = expansions
        @expansions.each_key do |expansion_type|
          normalized_expansion = build_and_normalize_expansion(@expansions[expansion_type], expansion_type)
          instance_variable_set(:"@#{expansion_type}", normalized_expansion)
          self.class.define_method(expansion_type) { instance_variable_get("@#{expansion_type}") }
        end
      end

      def build_and_normalize_expansion(entities, expansion_type)
        normalized_expansion = Tweetkit::Response::Expansions::Expansion.new(entities, expansion_type)
        normalized_expansion.normalized_expansion
      end

      # def method_missing(attribute, **args)
      #   response = expansions[attribute.to_s]
      #   response = super if response.nil?
      #   response
      # end

      # def respond_to_missing?(method)
      #   expansions.respond_to? method
      # end

      class Expansion
        include Enumerable

        attr_accessor :normalized_expansion

        EXPANSION_NORMALIZATION_KEY = {
          'users': 'id'
        }.freeze

        def initialize(entities, expansion_type)
          @normalized_expansion = {}
          normalization_key = EXPANSION_NORMALIZATION_KEY[expansion_type.to_sym]
          entities.each do |entity|
            key = entity[normalization_key]
            @normalized_expansion[key.to_i] = entity
          end
        end

        def each(*args, &block)
          data.each(*args, &block)
        end

        # def method_missing(attribute, **args)
        #   response = data[attribute.to_s]
        #   response = super if response.nil?
        #   response
        # end

        # def respond_to_missing?(method)
        #   data.respond_to? method
        # end

        def find(key)
          @entities[key]
        end
      end
    end

    class Meta
      include Enumerable

      attr_accessor :meta

      def initialize(meta)
        @meta = meta
      end

      def method_missing(attribute, **args)
        data = meta[attribute.to_s]
        data.empty? ? super : data
      end

      def respond_to_missing?(method)
        meta.respond_to? method
      end
    end

    class Tweets
      include Enumerable

      attr_accessor :tweets, :meta, :expansions

      def initialize(response)
        @tweets = response['data'].collect { |tweet| Tweetkit::Response::Tweet.new(tweet) }
        @meta = response['meta']
        @expansions = response['includes']
      end

      def each(*args, &block)
        tweets.each(*args, &block)
      end

      def last
        tweets.last
      end

      def to_s
        @tweets.join(' ')
      end

      def method_missing(attribute, **args)
        result = tweets.public_send(attribute, **args)
        super unless result
      rescue StandardError
        super
      end

      def respond_to_missing?(method)
        tweets.respond_to? method
      end
    end

    class Tweet
      attr_accessor :tweet

      def initialize(tweet)
        @tweet = tweet
      end

      def method_missing(attribute)
        data = tweet[attribute.to_s]
        data.empty? ? super : data
      end

      def respond_to_missing?(method)
        tweet.respond_to? method
      end
    end
  end
end
