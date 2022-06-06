require_relative 'player'
require_relative 'common'

class PlayerHuman < Player
  def mark_board
    print "#{Common.empty_line}What's your move, #{name} (#{mark})? (enter square number) "
    square_number =
      loop do
        input = gets.strip
        break input.to_i if board.move_valid?(input)

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
end
