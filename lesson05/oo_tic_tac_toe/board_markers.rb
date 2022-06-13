# Class must initialize `@board_markers` as an array of objects that include
# `BoardMarker`.
module BoardMarkers
  MARKS = %w[X O].freeze

  def assign_board_to_markers(board)
    board_markers.each { |marker| marker.assign_board(board) }
  end

  def assign_default_marks
    board_markers.each_with_index do |marker, idx|
      marker.assign_mark(MARKS[idx])
    end
  end

  private

  attr_reader :board_markers
end
