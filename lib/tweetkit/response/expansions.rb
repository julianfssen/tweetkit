module Tweetkit
  class Response
    # Class for initializing expansions data and converting them into their respective classes
    # @see https://developer.twitter.com/en/docs/twitter-api/expansions
    class Expansions
      attr_accessor :expansions
    
      def initialize(expansions)
        @expansions = expansions
      end

      # @return [Array<Tweetkit::Response::Expansions::MediaObject>] if the Media expansion is available.
      # @return [nil] if the Place expansion is not available.
      def media
        return if expansions["media"].nil?

        @media ||= expansions["media"].collect { |media_object| MediaObject.new(media_object) }
      end

      # @return [Array<Tweetkit::Response::Expansions::Place>] if the Places expansion is available.
      # @return [nil] if the Place expansion is not available.
      def places
        return if expansions["places"].nil?

        @places ||= expansions["places"].collect { |place| Place.new(place) }
      end

      # @return [Array<Tweetkit::Response::Expansions::Poll>] if the Poll expansion is available.
      # @return [nil] if the Poll expansion is not available.
      def polls
        return if expansions["polls"].nil?

        @polls ||= expansions["polls"].collect { |poll| Poll.new(poll) }
      end

      # @return [Tweetkit::Response::Tweets] if the Tweet expansion is available.
      # @return [nil] if the Tweet expansion is not available.
      def tweets
        return if expansions["tweets"].nil?

        @tweets ||= Tweetkit::Response::Tweets.new({ "data" => expansions["tweets"] })
      end

      # @return [Array<Tweetkit::Response::Expansions::User>] if the User expansion is available.
      # @return [nil] if the User expansion is not available.
      def users
        return if expansions["users"].nil?

        @users ||= expansions["users"].collect { |user| User.new(user) }
      end
    end
  end
end
