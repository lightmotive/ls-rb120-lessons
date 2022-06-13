require_relative 'abstract_not_implemented_error'

module BoardMarker
  attr_reader :mark, :board

  def assign_board(board)
    @board = board
  end

  def assign_mark(mark)
    @mark = mark
  end

  # Abstract: concrete should invoke `board[key] = self` (assign `BoardMarker` instance to space).
  def mark_board
    raise AbstractNotImplementedError
  end

  def to_s
    "#{super} (#{mark})"
  end

  protected

  # Get space keys that would complete a line for this instance.
  def keys_to_win
    keys_to_win_in_lines(board.all_lines)
  end

  # Get space keys that would complete a line for anyone other than this instance.
  def keys_to_defend
    keys_to_defend_in_lines(board.all_lines)
  end

  def keys_to_win_in_lines(lines)
    completion_sets_for_self = lines.select do |line|
      line.count { |space| space.marker == self } == board.size - 1
    end

    board.empty_keys_in_sets(completion_sets_for_self)
  end

  def keys_to_defend_in_lines(lines)
    completion_sets_against_self = lines.select do |line|
      line.count { |space| !space.unmarked? && space.marker != self } == board.size - 1
    end

    board.empty_keys_in_sets(completion_sets_against_self)
  end
end
