require_relative 'abstract_not_implemented_error'

class Player
  attr_reader :name, :board, :mark

  def initialize(name, board)
    @name = name
    @board = board
  end

  # Abstract: concrete should invoke `board[key] = self` (assign player to space).
  def mark_board
    raise AbstractNotImplementedError
  end

  def initialize_mark(mark)
    @mark = mark
  end

  def to_s
    "#{name} (#{mark})"
  end

  protected

  # Get space keys that would complete a line for this player.
  def keys_to_win
    keys_to_win_in_lines(board.all_lines)
  end

  # Get space keys that would complete a line for anyone other than this player.
  def keys_to_defend
    keys_to_defend_in_lines(board.all_lines)
  end

  def keys_to_win_in_lines(lines)
    completion_sets_for_self = lines.select do |line|
      line.count { |space| space.player == self } == board.size - 1
    end

    board.empty_keys_in_sets(completion_sets_for_self)
  end

  def keys_to_defend_in_lines(lines)
    completion_sets_against_self = lines.select do |line|
      line.count { |space| !space.empty? && space.player != self } == board.size - 1
    end

    board.empty_keys_in_sets(completion_sets_against_self)
  end
end
