class Square
  attr_reader :selection_value, :player

  def initialize(selection_value)
    @selection_value = selection_value
    mark(nil)
  end

  def mark(player)
    @player = player
  end

  def display
    return selection_value if player.nil?

    player.mark
  end
end
