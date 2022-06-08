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
    return false if winning_player.nil?

    true
  end

  def winning_player
    winning_line = winning_line(all_lines)
    return winning_line.first.player unless winning_line.nil?

    nil
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

  def winning_line(lines)
    lines.each do |line|
      first_square = line.first
      next if first_square.empty?
      return line if line.all? { |square| square.player == first_square.player }
    end

    nil
  end

  # Get square keys that would complete a line for a specific mark
  # (immediate threat/win).
  def keys_to_win_in_lines(for_player, lines)
    completion_sets = lines.select do |line|
      line.count { |square| square.player == for_player } == size - 1
    end

    empty_completion_squares = completion_sets.flatten.select(&:empty?)

    empty_completion_squares.map(&:key)
  end

  def keys_to_win(for_player)
    keys_to_win_in_lines(for_player, all_lines)
  end

  def all_lines
    hash_grid.rows.concat(hash_grid.columns, hash_grid.diagonals)
  end
end
