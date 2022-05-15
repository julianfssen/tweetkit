module Tweetkit
  # Module for checking client authentication methods
  module Auth
    private

    # Determines if requests are to be authenticated with OAuth 1.0a (with consumer and access tokens)
    #
    # @return [Boolean]
    def token_auth?
      !!(@consumer_key && @consumer_secret && @access_token && @access_token_secret)
    end

    # Determines if requests are to be authenticated with OAuth 2.0 (with a bearer token)
    #
    # @return [Boolean]
    def bearer_auth?
      !!@bearer_token
    end
  end
end
