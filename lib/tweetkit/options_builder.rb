module Tweetkit
  # Module for formatting and building options passed into +tweetkit+'s methods
  #
  # The +OptionsBuilder+ module formats fields and expansions options that are passed in
  # +tweetkit+'s HTTP methods.
  #
  # The formatted options are designed to fit Twitter's fields and expansions model, which are explained in detail here:
  #
  # * *Fields*: https://developer.twitter.com/en/docs/twitter-api/fields 
  # * *Expansions*: https://developer.twitter.com/en/docs/twitter-api/expansions
  #
  # Fields can be passed in two ways:
  #   # As a standalone argument
  #   client.tweet(123456790, tweet_fields: "attachments, author_id, created_at")
  #
  #   # As a hash with the :fields argument to pass in multiple fields
  #   client.tweet(123456790, fields: { tweet: "attachments, author_id, created_at" })
  #
  # The arguments expect values in two ways:
  #
  #   # 1) A comma-concatenated string of values
  #
  #   # With a standalone argument
  #   client.tweet(123456790, tweet_fields: "attachments, author_id, created_at")
  #
  #   # With a :fields hash
  #   client.tweet(123456790, fields: { tweet: "attachments, author_id, created_at" })
  #
  #   # ===============
  #
  #   # 2) An array of values
  #
  #   # With a standalone argument
  #   client.tweet(123456790, tweet_fields: ["attachments", "author_id", "created_at"])
  #
  #   # With a :fields hash
  #   client.tweet(123456790, fields: { tweet: ["attachments", "author_id", "created_at"] })
  #
  #   # Symbol and integer values can also be passed
  #   client.tweet(123456790, tweet_fields: ["attachments", :author_id, 10])
  #
  # Check the specific API reference for each Twitter endpoint to find out which fields or expansions are valid.
  # For example, the valid fields and expansions for fetching a single Tweet is listed here: 
  # https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets-id
  module OptionsBuilder
    private

    # Extracts the list of Twitter request fields to pass
    # @see https://developer.twitter.com/en/docs/twitter-api/fields
    #
    # @param options [Hash] Options from the request's body params
    #
    # @return [Hash] A hash of formatted Twitter v2 API fields to pass to the request
    def build_fields(options)
      fields = {}
      requested_fields = options.delete(:fields)

      if requested_fields && !requested_fields.empty?
        requested_fields.each do |field, value|
          if value.is_a?(Array)
            value = value.join(",")
          else
            value = value.delete(" ")
          end

          field = field.to_s.gsub("_", ".")
          fields.merge!({ "#{field}.fields" => value })
        end
      end

      options.each do |key, value|
        next unless key.match? "_fields"

        options.delete(key)

        if value.is_a? Array
          value = value.join(",")
        else
          value = value.delete(" ")
        end

        key = key.to_s.gsub("_", ".")
        fields.merge!({ key => value })
      end

      fields
    end

    # Extracts the list of Twitter request expansions to pass
    # @see https://developer.twitter.com/en/docs/twitter-api/expansions
    #
    # @param options [Hash] Options from the request's body params
    #
    # @return [Hash] A hash of formatted Twitter v2 API expansions to pass to the request
    def build_expansions(options)
      expansions = options.delete(:expansions)
      return unless expansions

      expansions = expansions.join(",") if expansions.is_a?(Array)
      { expansions: expansions }
    end

    def build_options(options)
      options = options.dup

      fields = build_fields(options)
      options.merge!(fields) if fields

      expansions = build_expansions(options)
      options.merge!(expansions) if expansions

      debugger

      options
    end
  end
end
