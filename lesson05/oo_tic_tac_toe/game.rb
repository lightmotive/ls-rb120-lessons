require_relative 'board'
require_relative 'player'

class Game
  def initialize(board_size = 3)
    @board = Board.new(board_size)
    identify_players
  end

  def play
    # Loop to play rounds and allow player to "play again"
  end

  private

  attr_reader :board, :players

  def identify_players
    # First version: identity human player's name
    # Randomize which player will go first
  end

  def play_round
    # Loop through players who mark board
    # Use `player.mark_board`
  end
end
