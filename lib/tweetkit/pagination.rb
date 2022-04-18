module Tweetkit
  module Pagination
    def next_page
      connection.params.merge!({ next_token: meta.next_token })
      response = connection.get(request[:previous_url])
      parse! response,
             connection: connection,
             twitter_request: {
               previous_url: request[:previous_url],
               previous_query: request[:previous_query]
             }
      self
    end

    def prev_page
      connection.params.merge!({ previous: meta.previous_token })
      response = connection.get(request[:previous_url])
      parse! response,
             connection: connection,
             twitter_request: {
               previous_url: request[:previous_url],
               previous_query: request[:previous_query]
             }
      self
    end
  end
end
