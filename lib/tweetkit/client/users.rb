require_relative 'search/search'

module Tweetkit
  class Client
    module Users
      def users_me(options = {})
        get 'users/me', **options
      end
    end
  end
end
