require_relative 'abstract_not_implemented_error'

class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  # Abstract
  def mark_board(_board)
    raise AbstractNotImplementedError
  end
end
