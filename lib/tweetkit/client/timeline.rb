module Tweetkit
  class Client
    module Timeline
      def timeline(id, **options)
        get "users/#{id}/tweets", **options
      end
    end
  end
end