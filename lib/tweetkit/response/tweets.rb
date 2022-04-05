module Tweetkit
  module Response
    class Tweets
      include Enumerable

      attr_accessor :annotations,
                    :connection,
                    :context_annotations,
                    :entity_annotations,
                    :expansions,
                    :fields,
                    :meta,
                    :options,
                    :original_response,
                    :response,
                    :tweets,
                    :twitter_request

      def initialize(response, **options)
        @response = response.body
        @tweets = extract_tweets(@response)
        return if @tweets.nil?

        @meta = Meta.new(@response['meta'])
        @expansions = Expansions.new(@response['includes'])
        @connection = options[:connection]
        @request = options[:request]
      end

      def extract_tweets(response)
        data = response['data']
        return if data.nil? || data.empty?

        data.collect { |tweet| Tweet.new(tweet) }
      end

      def each(*args, &block)
        tweets.each(*args, &block)
      end

      def last
        tweets.last
      end

      def next_page
        connection.params.merge!({ next_token: meta.next_token })
        response = connection.get(request[:previous_url])
        parse!(response,
               connection: connection,
               twitter_request: {
                 previous_url: request[:previous_url],
                 previous_query: request[:previous_query]
               })
        self
      end

      def prev_page
        connection.params.merge!({ previous: meta.previous_token })
        response = connection.get(request[:previous_url])
        parse!(response,
               connection: connection,
               twitter_request: {
                 previous_url: request[:previous_url],
                 previous_query: request[:previous_query]
               })
        self
      end

      class Expansions
        attr_accessor :media, :places, :polls, :tweets, :users
                                                                                                                                                                                          
        def initialize(expansions)
          return unless expansions
                                                                                                                                                                                          
          @media = Media.new(expansions['media'])
          @places = expansions['places']
          @polls = expansions['polls']
          @tweets = Tweets.new(expansions['tweets'])
          @users = Users.new(expansions['users'])
        end
                                                                                                                                                                                          
        class Media
          attr_accessor :media
                                                                                                                                                                                          
          def initialize(media)
            return unless media
                                                                                                                                                                                          
            @media = media.collect { |media_object| MediaObject.new(media_object) }
          end
                                                                                                                                                                                          
          class MediaObject
            attr_accessor :media_key, :type
                                                                                                                                                                                          
            def initialize(media_object)
              @media_key = media_object['media_key']
              @type = media_object['type']
            end
          end
        end
                                                                                                                                                                                          
        class Places
          attr_accessor :places
                                                                                                                                                                                          
          def initialize(places)
            return unless places
                                                                                                                                                                                          
            @places = places.collect { |place| Place.new(place) }
          end
                                                                                                                                                                                          
          class Place
            attr_accessor :full_name, :id
                                                                                                                                                                                          
            def initialize(place)
              @full_name = place['full_name']
              @id = place['id']
            end
          end
        end
                                                                                                                                                                                          
        class Polls
          attr_accessor :polls
                                                                                                                                                                                          
          def initialize(polls)
            return unless polls
                                                                                                                                                                                          
            @polls = polls.collect { |poll| Poll.new(poll) }
          end
                                                                                                                                                                                          
          class Poll
            attr_accessor :id, :options
                                                                                                                                                                                          
            def initialize(poll)
              @id = poll['id']
              @options = Options.new(poll['options'])
            end
                                                                                                                                                                                          
            class Options
              attr_accessor :options
                                                                                                                                                                                          
              def initialize(options)
                @options = options.collect { |option| Option.new(option) }
              end
                                                                                                                                                                                          
              class Option
                attr_accessor :label, :position, :votes
                                                                                                                                                                                          
                def initialize(option)
                  @label = option['label']
                  @position = option['position']
                  @votes = option['votes']
                end
              end
            end
          end
        end
                                                                                                                                                                                          
        class Tweets
          attr_accessor :tweets
                                                                                                                                                                                          
          def initialize(tweets)
            return unless tweets
                                                                                                                                                                                          
            @tweets = tweets.collect { |tweet| Tweet.new(tweet) }
          end
        end
                                                                                                                                                                                          
        class Users
          attr_accessor :users
                                                                                                                                                                                          
          def initialize(users)
            return unless users
                                                                                                                                                                                          
            @users = users.collect { |user| User.new(user) }
          end
                                                                                                                                                                                          
          class User
            attr_accessor :id, :name, :username
                                                                                                                                                                                          
            def initialize(user)
              @id = user['id']
              @name = user['name']
              @username = user['username']
            end
          end
        end
      end
                                                                                                                                                                                          
      class Fields
        attr_accessor :fields, :media_fields, :place_fields, :poll_fields, :tweet_fields, :user_fields
                                                                                                                                                                                          
        def initialize(fields)
          @fields = fields 
          build_and_normalize_fields(fields) unless fields.nil?
        end
                                                                                                                                                                                          
        def build_and_normalize_fields(fields)
          fields.each_key do |field_type|
            normalized_field = build_and_normalize_field(@fields[field_type], field_type)
            instance_variable_set(:"@#{field_type}", normalized_field)
            self.class.define_method(field_type) { instance_variable_get("@#{field_type}") }
          end
        end
                                                                                                                                                                                          
        def build_and_normalize_field(field, field_type)
          Field.new(field, field_type)
        end
                                                                                                                                                                                          
        def method_missing(method, **args)
          return nil if VALID_FIELDS.include?(method.to_s)
                                                                                                                                                                                          
          super
        end
                                                                                                                                                                                          
        def respond_to_missing?(method, *args)
          VALID_FIELDS.include?(method.to_s) || super
        end
                                                                                                                                                                                          
        class Field
          include Enumerable
                                                                                                                                                                                          
          attr_accessor :normalized_field, :original_field
                                                                                                                                                                                          
          FIELD_NORMALIZATION_KEY = {
            'users': 'id'
          }.freeze
                                                                                                                                                                                          
          def initialize(field, field_type)
            @original_field = field
            @normalized_field = {}
            normalization_key = FIELD_NORMALIZATION_KEY[field_type.to_sym]
            field.each do |data|
              key = data[normalization_key]
              @normalized_field[key.to_i] = data
            end
          end
                                                                                                                                                                                          
          def each(*args, &block)
            @normalized_field.each(*args, &block)
          end
                                                                                                                                                                                          
          def each_data(*args, &block)
            @normalized_field.values.each(*args, &block)
          end
                                                                                                                                                                                          
          def find(key)
            @normalized_field[key.to_i]
          end
        end
      end
                                                                                                                                                                                          
      class Meta
        attr_accessor :data
                                                                                                                                                                                          
        def initialize(meta)
          return unless meta
                                                                                                                                                                                          
          @data = meta
        end
                                                                                                                                                                                          
        def next_token
          @data['next_token']
        end
                                                                                                                                                                                          
        def previous_token
          @data['previous_token']
        end
      end
    end
  end
end
