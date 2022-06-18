require_relative 'common/common'
require_relative 'player'
require_relative 'board_marker'

class PlayerHuman < Player
  include BoardMarker

  def initialize(name)
    super(name, false)
  end

  def mark_board
    key = Common::Prompt.until_valid(
      "What's your move, #{name} (#{mark})? (enter board number)",
      convert_input: ->(input) { input.to_i },
      validate: validate_move_lambda
    )

    board[key] = self
  end

  def assign_custom_mark(disallowed_marks: [])
    assign_mark(prompt_custom_mark(disallowed_marks))
  end

  private

  def validate_move_lambda
    lambda do |converted_input|
      unless board.move_valid?(converted_input)
        raise Common::ValidationError,
              'Please enter a valid space number.'
      end
    end
  end

  def prompt_custom_mark(disallowed_marks = [])
    disallowed_message = disallowed_marks.empty? ? '' : ", excluding: #{disallowed_marks.join}"
    Common::Prompt.until_valid(
      "#{name}'s mark?",
      validate: lambda do |converted_input|
                  if converted_input.nil? || converted_input.empty? || converted_input.length > 1 ||
                     disallowed_marks.map(&:upcase).include?(converted_input.upcase)
                    raise Common::ValidationError, "Please enter a single-character mark#{disallowed_message}."
                  end
                end
    )
  end
end
