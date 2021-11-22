require_relative './spec_helper'

describe Tweetkit do
  it 'initializes a new client' do
    client = Tweetkit::Client.new(bearer_token: ENV['BEARER_TOKEN'])
    expect(client).to be_an_instance_of(Tweetkit::Client)
  end
end
