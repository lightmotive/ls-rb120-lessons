require_relative 'common/common'
require_relative 'hash_grid'
require_relative 'hash_grid_visual'
require_relative 'space'

class Board
  def initialize(size = nil)
    reset(size)
  end

  def reset(size = nil)
    size = size.nil? ? prompt_size : size
    @hash_grid = HashGrid.new(size, Space)
  end

  def size
    hash_grid.size
  end

  def draw(with_keys: false)
    HashGridVisual.new(hash_grid).draw(with_cell_keys: with_keys)
  end

  def empty_spaces
    hash_grid.empty_cells
  end

  def available_keys
    empty_spaces.map(&:key)
  end

  def full?
    hash_grid.full?
  end

  def move_valid?(input)
    available_keys.include?(input.to_i)
  end

  def []=(key, player)
    space = hash_grid[key]
    space.mark(player)
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

  def center_spaces(empty_only: false)
    hash_grid.center_cells(empty_only: empty_only)
  end

  def all_lines
    hash_grid.rows.concat(hash_grid.columns, hash_grid.diagonals)
  end

  def empty_keys_in_sets(completion_sets)
    empty_completion_spaces = completion_sets.flatten.select(&:empty?)
    empty_completion_spaces.map(&:key)
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
      first_space = line.first
      next if first_space.empty?
      return line if line.all? { |space| space.player == first_space.player }
    end

    nil
  end
end
