require_relative 'abstract_not_implemented_error'

class Player
  attr_reader :name, :mark

  def initialize(name)
    @name = name
  end

  def initialize_mark(mark)
    @mark = mark
  end

  # Abstract: concrete should accept `board` instance and call `board.mark(...)`.
  def mark_board(_board)
    raise AbstractNotImplementedError
  end
end
