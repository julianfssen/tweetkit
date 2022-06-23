# frozen_string_literal: true

module Tweetkit
  module Request
    class ValidExpansions
      Tweet = %w[
        attachments.media_keys
        attachments.poll_ids
        author_id
        entities.mentions.username
        geo.place_id
        in_reply_to_user_id
        referenced_tweets.id
        referenced_tweets.id.author_id
      ]

      User = %w[
        pinned_tweet_id
      ]

      class << self
        def all_expansions
          Tweet
        end
      end
    end
  end
end
