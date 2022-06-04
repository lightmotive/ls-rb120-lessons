require_relative 'player'

class PlayerHuman < Player
  def mark_board(board)
    # Request input to mark board, validate, and apply mark
    print "What's your move? (enter square number) "
    square_number =
      loop do
        input = gets.strip
        break input.to_i if move_input_valid?(board, input)

        print 'Please enter a valid square number: '
      end

    board.mark(self, square_number)
  end

  def self.request_name
    print "What's your name? "

    loop do
      name = gets.strip
      break name unless name.nil? || name.empty?
    end
  end

  private

  def move_input_valid?(board, input)
    board.available_square_selectors.include?(input)
  end
end
