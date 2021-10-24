require_relative '../spec_helper'

describe Tweetkit::Client::Tweets do
  before(:each) do
    @client = Tweetkit::Client.new(bearer_token: ENV['BEARER_TOKEN'])
  end

  describe '.tweet' do
    it 'accepts an ID and gets a tweet' do
      response = @client.tweet(1228393702244134912)

      expect(response.tweet.text).not_to be_empty
    end
  end

  describe '.tweets' do
    it 'accepts an array of IDs and gets the tweets' do
      response = @client.tweets([1228393702244134912, 1227640996038684673])

      expect(response.tweets.size).to eq(2)
      expect(response.tweets.first.text).not_to be_empty
    end

    it 'accepts comma-separated string of IDs and gets the tweets' do
      response = @client.tweets([1228393702244134912, 1227640996038684673])

      expect(response.tweets.size).to eq(2)
      expect(response.tweets.first.text).not_to be_empty
    end
  end
end
