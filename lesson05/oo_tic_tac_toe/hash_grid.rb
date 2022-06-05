require_relative 'validation_error'

class HashGrid
  attr_reader :size

  def initialize(size, value_factory)
    @size = size
    @value_factory = value_factory

    initialize_hash
  end

  def empty_cells
    hash.select { |_, value| value.empty? }.values
  end

  def full?
    empty_cells.empty?
  end

  def [](key)
    hash[key]
  end

  def rows
    keys = hash.keys

    size.times.map do
      size.times.map do
        hash[keys.shift]
      end
    end
  end

  def columns
    rows.transpose
  end

  def diagonals
    diagonal_by_index = ->(row, idx) { row[idx] }
    grid_rows = rows
    top_left_diagonal = grid_rows.map.with_index(&diagonal_by_index)
    bottom_left_diagonal = grid_rows.reverse.map.with_index(&diagonal_by_index)

    [top_left_diagonal, bottom_left_diagonal]
  end

  def center_cells(empty_only: false)
    middle_rows = center_cell_sets(rows)
    middle_columns = center_cell_sets(columns)

    center_cells = middle_rows.flatten.intersection(middle_columns.flatten)

    return center_cells.select(&:empty?) if empty_only

    center_cells
  end

  private

  attr_reader :value_factory, :hash

  def initialize_hash
    @hash = {}

    (1..size.abs2).each do |key|
      hash[key] = value_factory.call(key)
    end
  end

  def center_cell_sets(sets)
    if size.odd?
      [] << sets[size / 2]
    else
      first_middle = sets[(size / 2) - 1]
      last_middle = sets[size / 2]
      [first_middle, last_middle]
    end
  end
end
