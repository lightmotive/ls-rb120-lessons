require_relative 'stdout_format'

class HashGridVisual
  CELL_WIDTH_PAD = 1
  CELL_VERTICAL_PAD = 0
  CELL_WIDTH = (CELL_WIDTH_PAD * 2) + 1

  def initialize(hash_grid)
    @hash_grid = hash_grid
  end

  def draw(include_cell_numbers: false)
    row_strings = hash_grid.rows.map do |cells|
      "#{row_string(
        cells,
        include_cell_numbers: include_cell_numbers
      )}\n"
    end

    puts row_strings.join("#{row_divider}\n").to_s
  end

  private

  attr_reader :hash_grid

  def row_padding
    Array.new(hash_grid.size, ' ' * CELL_WIDTH).join('|')
  end

  def cell_key_display(cell)
    cell.key.to_s.rjust(CELL_WIDTH, ' ').italic.gray
  end

  def cell_display_with_padding(cell, include_cell_numbers)
    padding = ' ' * CELL_WIDTH_PAD

    display_string = cell.display
    display_string = display_string.bold unless cell.empty?

    if cell.empty? && include_cell_numbers
      display_string = cell_key_display(cell)
      padding.replace('')
    end

    display_string = ' ' if cell.empty? && !include_cell_numbers

    "#{padding}#{display_string}#{padding}"
  end

  def row_marks(cells, include_cell_numbers: false)
    cells.map do |cell|
      cell_display_with_padding(cell, include_cell_numbers)
    end.join('|')
  end

  def vertical_padding
    Array.new(CELL_VERTICAL_PAD, row_padding).join("\n")
  end

  def row_string(cells, include_cell_numbers: false)
    result = row_marks(cells, include_cell_numbers: include_cell_numbers)
    return result unless CELL_VERTICAL_PAD.positive?

    vpad = vertical_padding

    "#{vpad}\n#{result}\n#{vpad}"
  end

  def row_divider
    Array.new(hash_grid.size, '-' * CELL_WIDTH).join('+')
  end
end
