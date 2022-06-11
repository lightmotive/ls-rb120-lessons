require_relative 'common/common'

class GameRoundStatus
  attr_reader :win, :draw, :winner

  def initialize(board)
    @board = board
    @win = false
    @draw = false
    @winner = nil
  end

  def check_move(current_player)
    if board.winner?
      player_won(current_player)
    elsif board.full?
      players_drew
    end
  end

  def end?
    win || draw
  end

  def display_winner
    Common::Messages.bordered_display("#{winner} won the round!", '-')
  end

  def display_draw
    Common::Messages.bordered_display('Round draw!', '-')
  end

  private

  attr_reader :board

  def player_won(player)
    @win = true
    @winner = player
  end

  def players_drew
    @draw = true
  end
end
