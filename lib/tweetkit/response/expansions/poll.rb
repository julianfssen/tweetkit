module Tweetkit
  class Response
    class Expansions
      # Class for poll data in a Tweet's expansion
      class Poll
        attr_accessor :poll
      
        def initialize(poll)
          @poll = poll
        end

        # The unique identifier for the poll object
        #
        # @return [String]
        def id
          poll["id"]
        end

        # Returns how long the poll has been running in minutes
        #
        # @return [Integer]
        def duration_minutes
          poll["duration_minutes"]
        end

        # Specifies the end date and time for this poll in ISO8601 format
        #
        # @return [String]
        def end_datetime
          poll["end_datetime"]
        end

        # Indicates if this poll is still active and can receive votes, or if the voting is now closed.
        #
        # @return [String]
        def voting_status
          poll["voting_status"]
        end

        # Indicates if this poll is closed (no longer available for voting).
        #
        # @return [Boolean]
        def closed?
          poll["voting_status"] == "closed"
        end

        # Indicates if this poll is available for voting.
        #
        # @return [Boolean]
        def open?
          !closed?
        end

        alias_method :status, :voting_status
        alias_method :end, :end_datetime
        alias_method :duration, :duration_minutes

        # The list of options or choices for the poll
        #
        # @return [Options]
        def options
          @options = Options.new(poll["options"])
        end

        alias_method :choices, :options
      
        # Class for a Twitter poll's options
        class Options
          include Enumerable

          attr_accessor :options
      
          def initialize(options)
            @options = options.collect { |option| Option.new(option) }
          end

          def each(*args, &block)
            options.each(*args, &block)
          end
      
          # Class for a single Twitter poll option
          class Option
            attr_accessor :option
      
            def initialize(option)
              @option = option
            end

            # Text or content for the poll option
            #
            # @return [String]
            def label
              option["label"]
            end

            # The position of the option in the poll
            #
            # @return [Integer]
            def position
              option["position"]
            end

            # Number of votes for this option
            #
            # @return [Integer]
            def votes
              option["votes"]
            end

            alias_method :text, :label
            alias_method :content, :label
          end
        end
      end
    end
  end
end
