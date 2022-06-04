class Square
  attr_reader :selector, :player

  def initialize(selector)
    @selector = selector
    mark(nil)
  end

  def mark(player)
    @player = player

    self
  end

  def display
    return selector if player.nil?

    player.mark
  end
end
