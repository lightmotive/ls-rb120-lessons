require_relative 'grid'
require_relative 'square'

class Board
  include Grid

  attr_reader :size

  def initialize(size)
    @size = size
    create_grid(Square)
  end

  def draw
    # Output square grid of @size to console...
  end

  def available_squares
    grid.each_with_object([]) do |row, available|
      available.push(*row.reject(&:marked?))
    end
  end

  def available_selectors
    available_squares.map(&:selector)
  end

  def move_valid?(input)
    available_selectors.include?(input)
  end

  def mark(player, selector)
    square = select_square(selector)

    square.mark(player)
  end

  def winner?
    winning_line = self.winning_line()
    return false if winning_line.empty?

    true
  end

  private

  def select_square(selector)
    # Find square in grid using selector
  end

  def winning_line
    # ...select winning line
  end
end

p Board.new(3).available_selectors
