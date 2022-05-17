require_relative "../spec_helper"

describe Tweetkit::RequestOptionsBuilder do
  let(:client) { Tweetkit::Client.new }

  describe "fields builder" do
    it "accepts a :fields argument with a hash of values and returns a hash of fields correctly" do
      options = client.build_request_options(fields: { tweet: "attachments, author_id, created_at" })

      expect(options.has_key?("tweet.fields")).to be(true)
      expect(options["tweet.fields"]).to eq("attachments,author_id,created_at")
    end

    context "with a standalone argument" do
      it "accepts a comma-concatenated string of values and returns a hash of fields correctly" do
        options = client.build_request_options(tweet_fields: "attachments, author_id, created_at")

        expect(options.has_key?("tweet.fields")).to be(true)
        expect(options["tweet.fields"]).to eq("attachments,author_id,created_at")
      end

      it "accepts a array of values and returns a hash of fields correctly" do
        options = client.build_request_options(tweet_fields: ["attachments", "author_id", "created_at"])

        expect(options.has_key?("tweet.fields")).to be(true)
        expect(options["tweet.fields"]).to eq("attachments,author_id,created_at")
      end
    end
  end

  describe "expansions builder" do
    context "with an :expansions argument" do
      it "accepts a comma-concatenated string of values and returns a hash of expansions correctly" do
        options = client.build_request_options(expansions: "author_id, referenced_tweets.id, in_reply_to_user_id")

        expect(options.has_key?(:expansions)).to be(true)
        expect(options[:expansions]).to eq("author_id,referenced_tweets.id,in_reply_to_user_id")
      end

      it "accepts a array of values and returns a hash of expansions correctly" do
        options = client.build_request_options(expansions: ["author_id", "referenced_tweets.id", "in_reply_to_user_id"])

        expect(options.has_key?(:expansions)).to be(true)
        expect(options[:expansions]).to eq("author_id,referenced_tweets.id,in_reply_to_user_id")
      end
    end
  end

  # TODO: Add tests for combination of fields and expansions
end
