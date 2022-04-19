$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "dotenv"

BASE_ENV_FILE_PATH = ".env"

def traverse_for_env_file(env_file_path, stack_level)
  if stack_level > 5
    raise "ERROR: Cannot find .ENV file. Reason: Stack level too deep"
  end

  if File.exist?(env_file_path)
    Dotenv.load(env_file_path)
  else
    next_path = "../" + env_file_path
    traverse_for_env_file(next_path, stack_level + 1)
  end
end

traverse_for_env_file(BASE_ENV_FILE_PATH, 0)

require "debug"
require "tweetkit"
require "rspec"
