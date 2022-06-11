require_relative 'hash_grid_cell'

class Space < HashGridCell
  alias player value

  def display
    return key.to_s if player.nil?

    player.mark
  end

  def empty?
    player.nil?
  end

  def mark(player)
    self.value = player

    self
  end
end
