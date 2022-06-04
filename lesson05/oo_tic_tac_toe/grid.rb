module Grid
  attr_reader :grid

  def create_grid(of_type)
    @grid = []
    @grid_item_type = of_type

    create_grid_rows
  end

  private

  attr_reader :grid_item_type

  def create_grid_rows
    selector_start = 1

    size.times do
      grid.push(create_grid_columns(selector_start))
      selector_start += size
    end
  end

  def create_grid_columns(selector_start)
    selector_end = selector_start + size - 1

    (selector_start..selector_end).each_with_object([]) do |selector, row|
      row.push(grid_item_type.new(selector.to_s))
    end
  end
end
