require_relative '../spec_helper'

describe Tweetkit::Client::Tweets do
  client_types = {
    bearer_token: Tweetkit::Client.new(bearer_token: ENV['BEARER_TOKEN']),
    access_token: Tweetkit::Client.new(
      consumer_key: ENV['CONSUMER_KEY'],
      consumer_secret: ENV['CONSUMER_SECRET'],
      access_token: ENV['ACCESS_TOKEN'],
      access_token_secret: ENV['ACCESS_TOKEN_SECRET'],
    ),
  }

  client_types.each do |client_type, client|
    context "with #{client_type} client" do
      describe '.tweet' do
        it 'accepts an ID and gets a tweet' do
          response = client.tweet(1228393702244134912)

          expect(response.tweet.text).not_to be_empty
        end
      end

      describe '.tweets' do
        it 'accepts an array of IDs and gets the tweets' do
          response = client.tweets([1228393702244134912, 1227640996038684673])

          expect(response.tweets.size).to eq(2)
          expect(response.tweets.first.text).not_to be_empty
        end

        it 'accepts comma-separated string of IDs and gets the tweets' do
          response = client.tweets([1228393702244134912, 1227640996038684673])

          expect(response.tweets.size).to eq(2)
          expect(response.tweets.first.text).not_to be_empty
        end
      end
    end
  end

  context 'when user context is required' do
    let(:client) { client_types[:access_token] }

    describe '.post_tweet' do
      it 'posts text' do
        response = client.post_tweet(text: 'Hello world')
        expect(response.tweet.text).not_to be_empty
      end
    end

    describe '.delete_tweet' do
      it 'deletes a tweet' do
        create_response = client.post_tweet(text: 'Hello world')
        tweet_id = create_response.tweet.id.to_i
        delete_response = client.delete_tweet(tweet_id)

        expect(delete_response.response.dig('data', 'deleted')).to be(true)
      end
    end
  end
end
