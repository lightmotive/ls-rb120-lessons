require_relative 'player'
require_relative 'common'

class PlayerHuman < Player
  def mark_board
    key = Common::Prompt.until_valid(
      "#{Common::Messages.empty_line}What's your move, #{name} (#{mark})? (enter square number)",
      convert_input: ->(input) { input.to_i },
      validate: lambda do |converted_input|
                  raise ValidationError, 'Please enter a valid square number.' unless board.move_valid?(converted_input)
                end
    )

    board.mark(self, key)
  end

  def self.request_name
    Common::Prompt.until_valid(
      "What's your name",
      validate: lambda do |converted_input|
                  if converted_input.nil? || converted_input.empty?
                    raise ValidationError,
                          'Please enter something.'
                  end
                end
    )
  end
end
