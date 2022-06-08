require_relative 'abstract_not_implemented_error'

class Player
  attr_reader :name, :board, :mark

  def initialize(name, board)
    @name = name
    @board = board
  end

  def initialize_mark(mark)
    @mark = mark
  end

  def to_s
    "#{name} (#{mark})"
  end

  # Abstract: concrete should invoke `board.mark(...)`.
  def mark_board
    raise AbstractNotImplementedError
  end
end
