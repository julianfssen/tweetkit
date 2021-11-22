# Tweetkit

`Tweetkit` is a Ruby wrapper for [Twitter's V2 API](https://developer.twitter.com/en/docs/twitter-api/early-access).

`Tweetkit` is inspired by the original [Twitter gem](https://github.com/sferik/twitter) and the [Octokit ecosystem](https://github.com/octokit/octokit.rb).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tweetkit'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install tweetkit

## Usage

1. Require the gem.

```ruby
  require 'tweetkit'
```

2. Initialize a `Tweetkit::Client` instance by passing in your `Bearer Token` to work with Twitter's `OAuth 2.0` authorization requirement. You should also pass in your consumer key and token to perform requests that require `OAuth 1.0` authorization. 

[Read more on how to apply and access your Twitter tokens here.](https://developer.twitter.com/en/docs/twitter-api/getting-started/getting-access-to-the-twitter-api)

```ruby
  # Initializing via options
  client = Tweetkit::Client.new(bearer_token: 'YOUR_BEARER_TOKEN_HERE')

  # Initializing via options with OAuth 1.0 credentials
  client = Tweetkit::Client.new(bearer_token: 'YOUR_BEARER_TOKEN_HERE', consumer_key: 'YOUR_API_KEY_HERE', consumer_token: 'YOUR_API_TOKEN_HERE')

  # You can also initialize the client with a block
  client = Tweetkit::Client.new do |config|
    config.bearer_token = 'YOUR_BEARER_TOKEN_HERE'
    config.consumer_key = 'YOUR_API_KEY_HERE'
    config.consumer_token = 'YOUR_API_TOKEN_HERE'
  end
```

3. Interact with the Twitter API as needed. Below is an example of fetching a tweet with id `1234567890`.

```ruby
  response = client.tweet(1234567890)
```

## Documentation

Coming soon.

## Development

After checking out the repo, run `bin/setup` to install dependencies.

To run tests, first copy `.env.example` to `.env`, and modify it to include a valid Bearer token for the Twitter v2 API. Then, run `bundle exec rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/julianfssen/tweetkit.

