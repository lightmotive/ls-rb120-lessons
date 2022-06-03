class Board
  def initialize(size = 3)
    @size = size
  end

  def draw
    # Output square grid of @size to console...
  end

  def mark(player, selector)
    square = select_square(selector)

    square.mark(player)
  end

  def winner
    # Return a winner; nil if no winner
  end

  private

  attr_reader :size, :grid

  def select_square(selector)
    # Find square in grid using selector
  end
end
