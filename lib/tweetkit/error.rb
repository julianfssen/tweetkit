require "faraday"

module Tweetkit
  class Error < StandardError
    class ClientError < Faraday::ClientError; end
    class ServerError < Faraday::ServerError; end
  end
end
