require_relative 'hash_grid_cell'

# NOTE: `marker` represents the object that "marks the board". `mark` represents
# the mark that the object makes on the board.
class Space < HashGridCell
  alias marker value
  alias marker= value=

  def display
    return key.to_s if marker.nil?

    marker.mark
  end

  def empty?
    marker.nil?
  end

  alias unmarked? empty?

  # `marker` should be a `BoardMarker` instance.
  def mark(marker)
    self.marker = marker

    self
  end
end
