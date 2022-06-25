require "test_helper"

describe Tweetkit::Client::Tweets do
  client_types = {
    bearer_token: Tweetkit::Client.new(bearer_token: ENV["BEARER_TOKEN"]),
    access_token: Tweetkit::Client.new(
      consumer_key: ENV["CONSUMER_KEY"],
      consumer_secret: ENV["CONSUMER_SECRET"],
      access_token: ENV["ACCESS_TOKEN"],
      access_token_secret: ENV["ACCESS_TOKEN_SECRET"],
    ),
  }

  context "with bearer token auth" do
    let(:client) { client_types[:bearer_token] }

    describe ".tweet" do
      it "gets a tweet" do
        tweet = client.tweet(1228393702244134912)

        expect(tweet.text).not_to be_empty
      end
    end

    describe ".tweets" do
      it "accepts an array of IDs and gets the tweets" do
        response = client.tweets([1228393702244134912, 1227640996038684673])

        expect(response.tweets.size).to eq(2)
        expect(response.tweets.first.text).not_to be_empty
      end

      it "accepts comma-separated string of IDs and gets the tweets" do
        response = client.tweets("1228393702244134912, 1227640996038684673")

        expect(response.tweets.size).to eq(2)
        expect(response.tweets.first.text).not_to be_empty
      end
    end
  end

  context "when user context is required" do
    let(:client) { client_types[:access_token] }

    describe ".post_tweet" do
      it "posts text" do
        text = generate_text
        tweet = client.post_tweet(text: text)
        expect(tweet.text).to eq(text)
      end
    end

    describe ".delete_tweet" do
      it "deletes a tweet" do
        text = generate_text
        tweet = client.post_tweet(text: text)
        tweet_id = tweet.id.to_i
        deleted = client.delete_tweet(tweet_id)

        expect(deleted).to be(true)
      end
    end
  end

  private

  def generate_text
    random_string = rand(36 ** 8).to_s(36)

    "Hi! This is a random string to test the Tweetkit gem: #{random_string}"
  end
end
