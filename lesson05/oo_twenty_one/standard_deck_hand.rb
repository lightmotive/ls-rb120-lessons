class StandardDeckHand
  def initialize
    @array = []
  end

  def receive(card)
    array.push(card)
  end

  def to_s
    # string for displaying cards in console
  end

  private

  attr_reader :array
end
