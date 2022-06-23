module Tweetkit
  class Response
    # Class for initializing expansions data and converting them into their respective classes
    # @see https://developer.twitter.com/en/docs/twitter-api/expansions
    class Expansions
      attr_accessor :expansions
    
      def initialize(expansions)
        @expansions = expansions
      end

      # @return [Tweetkit::Response::Tweet::Expansions::Media]
      def media
        return if expansions["media"].nil?

        @media ||= Media.new(expansions["media"])
      end

      # @return [Tweetkit::Response::Tweet::Expansions::Places]
      def places
        return if expansions["places"].nil?

        @places ||= Places.new(expansions["places"])
      end

      # @return [Tweetkit::Response::Tweet::Expansions::Polls]
      def polls
        return if expansions["polls"].nil?

        @polls ||= Polls.new(expansions["polls"])
      end

      # @return [Tweetkit::Response::Tweets]
      def tweets
        return if expansions["tweets"].nil?

        @tweets ||= Tweets.new(expansions["tweets"])
      end

      # @return [Tweetkit::Response::Tweet::Expansions::Users]
      def users
        return if expansions["users"].nil?

        @users ||= Users.new(expansions["users"])
      end
    end
  end
end
