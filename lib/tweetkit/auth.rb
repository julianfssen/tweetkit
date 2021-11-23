module Tweetkit
  module Auth
    def token_auth?
      !!(@consumer_key && @consumer_secret && @access_token && @access_token_secret)
    end

    def bearer_auth?
      !!@bearer_token
    end
  end
end
