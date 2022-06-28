require_relative 'common/common'

class TicTacToeGameRound
  STATUS_MESSAGES = { win: '%<winner>s won the round!',
                      draw: 'Round draw!' }.freeze

  attr_reader :status, :winner

  def initialize(board)
    @board = board
    @status = nil
    @winner = nil
  end

  def check_move(current_player)
    if board.winner?
      self.status = :win
      @winner = current_player
    elsif board.full?
      self.status = :draw
    end
  end

  def end?
    %i[win draw].include?(status)
  end

  def display_status
    Common::Messages.bordered_display(STATUS_MESSAGES[status] % to_hash, '-')
  end

  private

  attr_reader :board
  attr_writer :status

  def to_hash
    { status: status, winner: winner }
  end
end
