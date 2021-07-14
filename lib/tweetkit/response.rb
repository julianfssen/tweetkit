require 'json'
require 'pry'

module Tweetkit
  class Response
    attr_accessor :resources, :meta, :original_response, :tweets

    def initialize(response)
      @original_response = response.body
      parsed_response = JSON.parse(@original_response)
      @tweets = Tweetkit::Response::Tweets.new(parsed_response)
      @meta = Tweetkit::Response::Meta.new(@tweets.meta)
      @resources = Tweetkit::Response::Resources.new(@tweets.resources)
    end

    class Resources
      include Enumerable

      VALID_RESOURCES = Set['users', 'tweets', 'media']

      attr_accessor :resources

      def initialize(resources)
        @resources = resources
        build_and_normalize_resources(resources) unless resources.nil?
      end

      def build_and_normalize_resources(resources)
        resources.each_key do |resource_type|
          normalized_resource = build_and_normalize_resource(@resources[resource_type], resource_type)
          instance_variable_set(:"@#{resource_type}", normalized_resource)
          self.class.define_method(resource_type) { instance_variable_get("@#{resource_type}") }
        end
      end

      def build_and_normalize_resource(resource, resource_type)
        Tweetkit::Response::Resources::Resource.new(resource, resource_type)
      end

      def method_missing(method, **args)
        return nil if VALID_RESOURCES.include?(method.to_s)

        super
      end

      def respond_to_missing?(method, *args)
        Set.include?(method.to_s) || super
      end

      class Resource
        include Enumerable

        attr_accessor :normalized_resource, :original_resource

        RESOURCE_NORMALIZATION_KEY = {
          'users': 'id'
        }.freeze

        def initialize(resource, resource_type)
          @original_resource = resource
          @normalized_resource = {}
          normalization_key = RESOURCE_NORMALIZATION_KEY[resource_type.to_sym]
          resource.each do |data|
            key = data[normalization_key]
            @normalized_resource[key.to_i] = data
          end
        end

        def each(*args, &block)
          @normalized_resource.each(*args, &block)
        end

        def each_data(*args, &block)
          @normalized_resource.values.each(*args, &block)
        end

        def find(key)
          @normalized_resource[key.to_i]
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

      def respond_to_missing?(method, *args)
        meta.respond_to? method
      end
    end

    class Tweets
      include Enumerable

      attr_accessor :tweets, :meta, :resources

      def initialize(response)
        @tweets = response['data'] ? response['data'].collect { |tweet| Tweetkit::Response::Tweet.new(tweet) } : []
        @meta = response['meta']
        @resources = response['includes']
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

      def method_missing(method, **args)
        tweets.public_send(method, **args)
      end

      def respond_to_missing?(method, *args)
        tweets.respond_to?(method)
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

      def respond_to_missing?(method, *args)
        tweet.respond_to?(method) || super
      end
    end
  end
end
