require_relative 'player'

class PlayerComputer < Player
  def initialize
    super('Computer')
  end

  def mark_board(board)
    board.mark(self, board.available_square_selectors.sample)
  end
end
