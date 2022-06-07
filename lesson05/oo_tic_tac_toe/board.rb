require_relative 'common/common'
require_relative 'hash_grid'
require_relative 'hash_grid_visual'
require_relative 'square'

class Board
  attr_reader :size

  def initialize(size = 3)
    reset(size)
  end

  def reset(size = nil)
    @size = size.nil? ? prompt_size : size
    @hash_grid = HashGrid.new(self.size, Square)
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

  def prompt_size
    Common::Prompt.until_valid(
      'What size board? (enter 3-9)',
      convert_input: ->(input) { input.to_i },
      validate: lambda do |converted_input|
                  unless converted_input.between?(3, 9)
                    raise Common::ValidationError, 'Please enter a board size value between 3 and 9.'
                  end
                end
    )
  end

  def winning_line
    # Refactor ls-rb101-lessons/lesson6_slightly_larger_programs/04_tic_tac_toe/gameplay_win.rb to class that uses `hash_grid`...
    []
  end
end
