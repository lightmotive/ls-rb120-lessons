require_relative 'validation_error'
require_relative 'prompt/prompt'
require_relative 'messages/messages'

module Common
  def self.clear_console
    system('clear')
  end
end
