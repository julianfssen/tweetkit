require_relative '../spec_helper'

describe Tweetkit::Client::Timeline do
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
      describe '.timeline' do
        it 'accepts a twitter user ID and gets a timeline' do
          response = client.timeline(21720472)

          expect(response.tweets.length).to eq(10)
          expect(response.tweets.first.text).not_to be_empty
        end
      end
    end
  end
end