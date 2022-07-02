require "test_helper"

class Tweetkit::Request::OptionsBuilderTest < Minitest::Test
  def setup
    @client = Tweetkit::Client.new
  end

  def test_fields_builder_with_hash_values
    options = @client.build_request_options(fields: { tweet: "attachments, author_id, created_at" })

    assert_equal "attachments,author_id,created_at", options["tweet.fields"]
  end

  def test_fields_builder_with_string_values
    options = @client.build_request_options(tweet_fields: "attachments, author_id, created_at")

    assert_equal "attachments,author_id,created_at", options["tweet.fields"]
  end

  def test_fields_builder_with_array_values
    options = @client.build_request_options(tweet_fields: ["attachments", "author_id", "created_at"])

    assert_equal "attachments,author_id,created_at", options["tweet.fields"]
  end

  def test_expansions_builder_with_string_values
    options = @client.build_request_options(expansions: "author_id, referenced_tweets.id, in_reply_to_user_id")

    assert_equal "author_id,referenced_tweets.id,in_reply_to_user_id", options["expansions"]
  end

  def test_expansions_builder_with_array_values
    options = @client.build_request_options(expansions: ["author_id", "referenced_tweets.id", "in_reply_to_user_id"])

    assert_equal "author_id,referenced_tweets.id,in_reply_to_user_id", options["expansions"]
  end

  def test_fields_and_expansions_combined_query
    options = @client.build_request_options(
      tweet_fields: "attachments, author_id, created_at",
      fields: { media: ["public_metrics", "duration_ms"] },
      expansions: "author_id, referenced_tweets.id, in_reply_to_user_id"
    )

    assert_equal "attachments,author_id,created_at", options["tweet.fields"] 
    assert_equal "public_metrics,duration_ms", options["media.fields"]
    assert_equal "author_id,referenced_tweets.id,in_reply_to_user_id", options["expansions"]
  end
end
