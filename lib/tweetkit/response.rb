# frozen_string_literal: true

require 'json'

module Tweetkit
  module Response
    class Tweets
      include Enumerable

      attr_accessor :annotations, :connection, :context_annotations, :entity_annotations, :expansions, :fields, :meta, :options, :original_response, :response, :tweets, :user, :twitter_request

      def initialize(response, **options)
        parse! response, **options
      end

      def parse!(response, **options)
        parse_response response
        if response.env.url.to_s.include?('/users/me')
          extract_and_save_user
          return unless @user
        else
          extract_and_save_tweets
          return unless @tweets
        end

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

      def extract_and_save_user
        @user = nil
        @user = Tweetkit::Response::Tweets::Expansions::Users::User.new(@response['data']) if (data = @response['data'])
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

      class Tweet
        attr_accessor :annotations, :attachments, :data

        def initialize(tweet)
          @data = tweet
          @annotations = Annotations.new(data['context_annotations'], data['entities'])
          @attachments = Attachments.new(data['attachments'])
        end

        def id
          data['id']
        end

        def text
          data['text']
        end

        def author_id
          data['author_id']
        end

        def conversation_id
          data['conversation_id']
        end

        def created_at
          data['created_at']
        end

        def reply_to
          in_reply_to_user_id
        end

        def in_reply_to_user_id
          data['in_reply_to_user_id']
        end

        def lang
          data['lang']
        end

        def nsfw?
          possibly_sensitive
        end

        def sensitive?
          possibly_sensitive
        end

        def possibly_sensitive
          data['possibly_sensitive']
        end

        def permission
          reply_settings
        end

        def reply_settings
          data['reply_settings']
        end

        def device
          source
        end

        def source
          data['source']
        end

        def withheld?
          withheld && !withheld.empty?
        end

        def withheld
          data['withheld']
        end

        def context_annotations
          @annotations.context_annotations || nil
        end

        def entity_annotations
          entities
        end

        def entities
          @annotations.entity_annotations || nil
        end

        class Attachments
          attr_accessor :media_keys, :poll_ids

          def initialize(attachments)
            return unless attachments

            @media_keys = attachments['media_keys']
            @poll_ids = attachments['poll_ids']
          end
        end

        class Annotations
          attr_accessor :context_annotations, :entity_annotations

          def initialize(context_annotations, entity_annotations)
            return unless context_annotations || entity_annotations

            @context_annotations = Context.new(context_annotations)
            @entity_annotations = Entity.new(entity_annotations)
          end

          class Context
            include Enumerable

            attr_accessor :annotations

            def initialize(annotations)
              return unless annotations

              @annotations = annotations.collect { |annotation| Annotation.new(annotation) }
            end

            def each(*args, &block)
              annotations.each(*args, &block)
            end

            class Annotation
              attr_accessor :domain, :entity

              def initialize(annotation)
                @domain = annotation['domain']
                @entity = annotation['entity']
              end
            end
          end

          class Entity
            include Enumerable

            attr_accessor :annotations, :cashtags, :hashtags, :mentions, :urls

            def initialize(entity_annotations)
              return unless entity_annotations

              @annotations = Annotations.new(entity_annotations['annotations'])
              @cashtags = Cashtags.new(entity_annotations['cashtags'])
              @hashtags = Hashtags.new(entity_annotations['hashtags'])
              @mentions = Mentions.new(entity_annotations['mentions'])
              @urls = Urls.new(entity_annotations['urls'])
            end

            def each(*args, &block)
              annotations.each(*args, &block)
            end

            class Annotations
              attr_accessor :annotations

              def initialize(annotations)
                return unless annotations

                @annotations = annotations.collect { |annotation| Annotation.new(annotation) }
              end

              class Annotation
                attr_accessor :end, :probability, :start, :text, :type

                def initialize(annotation)
                  @end = annotation['end']
                  @probability = annotation['probability']
                  @start = annotation['start']
                  @text = annotation['normalized_text']
                  @type = annotation['type']
                end
              end
            end

            class Cashtags
              attr_accessor :cashtags

              def initialize(cashtags)
                return unless cashtags

                @cashtags = cashtags.collect { |cashtag| Cashtag.new(cashtag) }
              end

              class Cashtag
                attr_accessor :end, :start, :tag

                def initialize(cashtag)
                  @end = cashtag['end']
                  @start = cashtag['start']
                  @tag = cashtag['tag']
                end
              end
            end

            class Hashtags
              attr_accessor :hashtags

              def initialize(hashtags)
                return unless hashtags

                @hashtags = hashtags.collect { |hashtag| Hashtag.new(hashtag) }
              end

              class Hashtag
                attr_accessor :end, :start, :tag

                def initialize(hashtag)
                  @end = hashtag['end']
                  @start = hashtag['start']
                  @tag = hashtag['tag']
                end
              end
            end

            class Mentions
              attr_accessor :mentions

              def initialize(mentions)
                return unless mentions

                @mentions = mentions.collect { |mention| Mention.new(mention) }
              end

              class Mention
                attr_accessor :end, :id, :start, :username

                def initialize(mention)
                  @end = mention['end']
                  @id = mention['id']
                  @start = mention['start']
                  @username = mention['username']
                end
              end
            end

            class Urls
              attr_accessor :urls

              def initialize(urls)
                return unless urls

                @urls = urls.collect { |url| Url.new(url) }
              end

              class Url
                attr_accessor :description, :display_url, :end, :expanded_url, :start, :status, :title, :url, :unwound_url

                def initialize(url)
                  @description = url['description']
                  @display_url = url['display_url']
                  @end = url['end']
                  @expanded_url = url['expanded_url']
                  @start = url['start']
                  @status = url['status']
                  @title = url['title']
                  @url = url['url']
                  @unwound_url = url['unwound_url']
                end
              end
            end
          end
        end

        class Geo
          attr_accessor :coordinates, :place_id

          def initialize(geo)
            return unless geo

            @coordinates = Coordinates.new(geo['coordinates'])
            @place_id = geo['place_id']
          end

          class Coordinates
            attr_accessor :coordinates, :type

            def initialize(coordinates)
              @coordinates = coordinates['coordinates']
              @type = coordinates['point']
            end

            def x
              coordinates[0]
            end

            def y
              coordinates[0]
            end
          end
        end

        class Metrics
          attr_accessor :public_metrics

          def initialize(**metrics)
            return unless metrics

            @public_metrics = Public.new(metrics[:public_metrics])
          end

          class Public
            attr_accessor :like_count, :quote_count, :reply_count, :retweet_count

            def initialize(public_metric)
              @like_count = public_metric['like_count']
              @quote_count = public_metric['quote_count']
              @reply_count = public_metric['reply_count']
              @retweet_count = public_metric['retweet_count']
            end

            def likes
              @like_count
            end

            def quotes
              @quote_count
            end

            def replies
              @reply_count
            end

            def retweets
              @retweet_count
            end
          end
        end
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
