require_relative 'hash_grid'
require_relative 'hash_grid_visual'
require_relative 'square'

class Board
  def initialize(size)
    @hash_grid = HashGrid.new(size, ->(key) { Square.new(key) })
  end

  def draw(display_selectors: false)
    HashGridVisual.new(hash_grid).draw(include_cell_numbers: display_selectors)
  end

  def empty_squares
    hash_grid.empty_cells
  end

  def available_selectors
    empty_squares.map(&:key)
  end

  def full?
    hash_grid.full?
  end

  def move_valid?(input)
    available_selectors.include?(input.to_i)
  end

  def mark(player, key)
    square = hash_grid[key]
    square.mark(player)
  end

  def winner?
    return false if winning_line.empty?

    true
  end

  private

  attr_reader :hash_grid

  def winning_line
    # Refactor ls-rb101-lessons/lesson6_slightly_larger_programs/04_tic_tac_toe/gameplay_win.rb to class that uses `hash_grid`...
    []
  end
end
