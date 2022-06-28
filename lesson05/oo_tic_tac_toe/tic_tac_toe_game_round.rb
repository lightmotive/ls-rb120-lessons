require_relative 'game_round'

class TicTacToeGameRound < GameRound
  def initialize(board)
    super()
    @board = board
  end

  def check_move(current_player)
    if board.winner?
      self.status = :win
      self.winner = current_player
    elsif board.full?
      self.status = :draw
    end
  end

  private

  attr_reader :board
end
