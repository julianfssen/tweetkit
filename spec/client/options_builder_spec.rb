require_relative "../spec_helper"

describe Tweetkit::Request::OptionsBuilder do
  let(:client) { Tweetkit::Client.new }

  describe "fields builder" do
    it "accepts a :fields argument with a hash of values and returns a hash of fields correctly" do
      options = client.build_request_options(fields: { tweet: "attachments, author_id, created_at" })

      expect(options["tweet.fields"]).to eq("attachments,author_id,created_at")
    end

    context "with a standalone argument" do
      it "accepts a comma-concatenated string of values and returns a hash of fields correctly" do
        options = client.build_request_options(tweet_fields: "attachments, author_id, created_at")

        expect(options["tweet.fields"]).to eq("attachments,author_id,created_at")
      end

      it "accepts a array of values and returns a hash of fields correctly" do
        options = client.build_request_options(tweet_fields: ["attachments", "author_id", "created_at"])

        expect(options["tweet.fields"]).to eq("attachments,author_id,created_at")
      end
    end
  end

  describe "expansions builder" do
    context "with an :expansions argument" do
      it "accepts a comma-concatenated string of values and returns a hash of expansions correctly" do
        options = client.build_request_options(expansions: "author_id, referenced_tweets.id, in_reply_to_user_id")

        expect(options["expansions"]).to eq("author_id,referenced_tweets.id,in_reply_to_user_id")
      end

      it "accepts a array of values and returns a hash of expansions correctly" do
        options = client.build_request_options(expansions: ["author_id", "referenced_tweets.id", "in_reply_to_user_id"])

        expect(options["expansions"]).to eq("author_id,referenced_tweets.id,in_reply_to_user_id")
      end
    end
  end

  describe "combined query" do
    it "accepts a combination of fields and expansions and returns a hash of request options correctly" do
      options = client.build_request_options(
        tweet_fields: "attachments, author_id, created_at",
        fields: { media: ["public_metrics", "duration_ms"] },
        expansions: "author_id, referenced_tweets.id, in_reply_to_user_id"
      )

      expect(options["tweet.fields"]).to eq("attachments,author_id,created_at")
      expect(options["media.fields"]).to eq("public_metrics,duration_ms")
      expect(options["expansions"]).to eq("author_id,referenced_tweets.id,in_reply_to_user_id")
    end
  end
end
