require_relative "./spec_helper"

describe Tweetkit do
  it "initializes a new client" do
    client = Tweetkit::Client.new(bearer_token: ENV["BEARER_TOKEN"])
    expect(client).to be_an_instance_of(Tweetkit::Client)
  end

  it "initializes a new client with default environment variables" do
    client = Tweetkit::Client.new
    expect(client).to be_an_instance_of(Tweetkit::Client)
  end
end
