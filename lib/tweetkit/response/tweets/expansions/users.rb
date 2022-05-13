module Tweetkit
  class Response
    class Tweets
      class Expansions
        class Users
          attr_accessor :users
        
          def initialize(users)
            return unless users
        
            @users = users.collect { |user| User.new(user) }
          end
        
          class User
            attr_accessor :id, :name, :username
        
            def initialize(user)
              @id = user["id"]
              @name = user["name"]
              @username = user["username"]
            end
          end
        end
      end
    end
  end
end
