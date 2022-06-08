require_relative 'hash_grid_cell'

class Space < HashGridCell
  attr_reader :player

  def initialize(key)
    super
    mark(nil)
  end

  def display
    return key.to_s if player.nil?

    player.mark
  end

  def empty?
    player.nil?
  end

  def mark(player)
    @player = player

    self
  end
end
