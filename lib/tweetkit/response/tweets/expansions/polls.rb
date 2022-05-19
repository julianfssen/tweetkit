module Tweetkit
  class Response
    class Tweets
      class Expansions
        class Polls
          attr_accessor :polls
        
          def initialize(polls)
            return unless polls
        
            @polls = polls.collect { |poll| Poll.new(poll) }
          end
        
          # Class for poll data in a Tweet's expansion
          class Poll
            attr_accessor :id, :options
        
            def initialize(poll)
              @id = poll['id']
              @options = Options.new(poll['options'])
            end
        
            # Class for a Twitter poll's options
            class Options
              attr_accessor :options
        
              def initialize(options)
                @options = options.collect { |option| Option.new(option) }
              end
        
              # Class for a single Twitter poll option
              class Option
                attr_accessor :label, :position, :votes
        
                def initialize(option)
                  @label = option['label']
                  @position = option['position']
                  @votes = option['votes']
                end
              end
            end
          end
        end
      end
    end
  end
end
