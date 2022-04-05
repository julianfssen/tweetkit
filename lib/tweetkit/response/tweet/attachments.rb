module Tweetkit::Response::Tweet
  class Attachments
    attr_accessor :media_keys, :poll_ids
  
    def initialize(attachments)
      return unless attachments
  
      @media_keys = attachments['media_keys']
      @poll_ids = attachments['poll_ids']
    end
  end
end
