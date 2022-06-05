require_relative 'stdout_format'

class HashGridVisual
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

    puts row_strings.join("#{row_divider(hash_grid.size)}\n").to_s
  end

  private

  SPACE_WIDTH_PADDING = 1
  SPACE_VERTICAL_PADDING = 0
  SPACE_WIDTH = (SPACE_WIDTH_PADDING * 2) + 1

  attr_reader :hash_grid

  def row_padding(column_count)
    Array.new(column_count, ' ' * SPACE_WIDTH).join('|')
  end

  def cell_key_display(cell)
    cell.key.to_s.rjust(SPACE_WIDTH, ' ').italic.gray
  end

  def cell_display_with_padding(cell, include_cell_numbers)
    padding = ' ' * SPACE_WIDTH_PADDING

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

  def row_string(cells, include_cell_numbers: false)
    result = row_marks(
      cells, include_cell_numbers: include_cell_numbers
    )

    return result unless SPACE_VERTICAL_PADDING.positive?

    vertical_padding = Array.new(
      SPACE_VERTICAL_PADDING,
      row_padding(cells.size)
    ).join("\n")

    "#{vertical_padding}\n#{result}\n#{vertical_padding}"
  end

  def row_divider(column_count)
    Array.new(column_count, '-' * SPACE_WIDTH).join('+')
  end
end
