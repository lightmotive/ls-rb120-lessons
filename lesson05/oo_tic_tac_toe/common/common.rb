# NOTE: Other programs in this lesson reference this file. To be migrated to a private gem.
# [Private Gems starting point](https://medium.com/@bernardomg/build-a-private-ruby-gem-b5f53dc2e911).
require_relative 'validation_error'
require_relative 'prompt/prompt'
require_relative 'messages/messages'

module Common
  def self.clear_console
    system('clear')
  end
end
