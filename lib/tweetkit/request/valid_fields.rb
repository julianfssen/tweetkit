# frozen_string_literal: true

module Tweetkit
  module Request
    class ValidFields
      PrivateFields = %w[
        non_public_metrics
        promoted_metrics
        organic_metrics
      ]

      Media = %w[
        alt_text
        duration_ms
        height
        media_key
        non_public_metrics
        organic_metrics
        public_metrics
        preview_image_url
        promoted_metrics
        type
        url
        width
        variants
      ]

      Place = %w[
        contained_within
        country
        country_code
        full_name
        geo
        id
        name
        place_type
      ]

      Poll = %w[
        duration_minutes
        end_datetime
        id
        options
        voting_status
      ]

      Tweet = %w[
        attachments
        author_id
        context_annotations
        conversation_id
        created_at
        entities
        geo
        id
        in_reply_to_user_id
        lang
        non_public_metrics
        public_metrics
        organic_metrics
        promoted_metrics
        possibly_sensitive
        referenced_tweets
        reply_settings
        source
        text
        withheld
      ]

      User = %w[
        created_at
        description
        entities
        id
        location
        name
        pinned_tweet_id
        profile_image_url
        protected
        public_metrics
        url
        username
        verified
        withheld
      ]

      class << self
        def fields
          constants - [:PrivateFields]
        end

        def all_public_fields
          fields.collect do |resource|
            fields = const_get(resource) - PrivateFields
            [resource.downcase, fields]
          end
        end

        def all_fields
          fields.collect do |resource|
            fields = const_get(resource)
            [resource.downcase, fields]
          end
        end
      end
    end
  end
end
