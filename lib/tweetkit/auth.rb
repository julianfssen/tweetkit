module Tweetkit
  module Auth
    def basic_auth?
      !!(@login && @password)
    end

    def token_auth?
      !!(@access_token && @access_token_secret)
    end

    def bearer_auth?
      !!@bearer_token
    end
  end
end
