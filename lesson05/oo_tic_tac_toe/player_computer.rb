# frozen_string_literal: true

require_relative 'player'
require_relative 'board_marker'

class PlayerComputer < Player
  include BoardMarker

  # TODO: Improve computer logic to play best strategy, regardless of board size:
  # - Strategy: https://en.wikipedia.org/wiki/Tic-tac-toe#:~:text=cat's%20game%22%5B15%5D)-,strategy
  # - Minimax algorithm: https://www.youtube.com/watch?v=trKjYdBASyQ

  NAME = 'Computer'

  def initialize
    super(NAME, true)
  end

  def mark_board
    board[select_key] = self
  end

  private

  def key_to_play
    center_spaces = board.center_spaces
    empty_center_spaces = board.center_spaces(empty_only: true)
    return nil if center_spaces.size > 1 || empty_center_spaces.empty?

    empty_center_spaces.sample.key
  end

  def select_key
    key_to_win = keys_to_win.first
    return key_to_win unless key_to_win.nil?

    key_to_defend = keys_to_defend.sample
    return key_to_defend unless key_to_defend.nil?

    key_to_play = self.key_to_play
    return key_to_play unless key_to_play.nil?

    board.available_keys.sample
  end
end
