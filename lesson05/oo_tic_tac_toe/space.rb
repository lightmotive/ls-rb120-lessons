require_relative 'hash_grid_cell'

class Space < HashGridCell
  alias player value
  alias player= value=

  def display
    return key.to_s if player.nil?

    player.mark
  end

  def empty?
    player.nil?
  end

  def mark(player)
    self.player = player

    self
  end
end
