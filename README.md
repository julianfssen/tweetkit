# Tweetkit

## ⚠️  In Development

The gem is currently in development and is **NOT** recommended for production use. [I'm currently working on a beta branch with complete docs, tests, and updated endpoints](https://github.com/julianfssen/tweetkit/tree/v-0.3.0-beta-dev). Feel free to try the beta branch out!

## I want to use a Twitter / X gem in production

I recommend you to use the [`x-ruby`](https://github.com/sferik/x-ruby) gem which is maintained by `sferik`, the original author of the `twitter` gem. 

After Twitter updated their API policy, I no longer have access to almost all API endpoints without forking out $100 per month, which is very expensive for me at the moment.

I'll be thinking of ways to further improve this gem but until then, the `x-ruby` gem I mentioned above is a much better candidate for production use.

---

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
  client = Tweetkit::Client.new(bearer_token: 'YOUR_BEARER_TOKEN_HERE', consumer_key: 'YOUR_CONSUMER_KEY_HERE', consumer_secret: 'YOUR_CONSUMER_SECRET_HERE')

  # You can also initialize the client with a block
  client = Tweetkit::Client.new do |config|
    config.bearer_token = 'YOUR_BEARER_TOKEN_HERE'
    config.consumer_key = 'YOUR_CONSUMER_KEY_HERE'
    config.consumer_secret = 'YOUR_CONSUMER_SECRET_HERE'
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

