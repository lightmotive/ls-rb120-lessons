require_relative 'standard_deck_hand'

class TwentyOneHand < StandardDeckHand
  WINNING_SCORE = 21

  attr_reader :total

  def initialize
    super
  end

  def receive(card)
    super
    calculate_total
  end

  def busted?
    total > WINNING_SCORE
  end

  def won?
    total == WINNING_SCORE
  end

  def to_s
    "#{super} #{total}"
  end

  private

  def calculate_total
    raise('To be implemented...')
    # Calculate total here (numeric value of cards in Twenty One game)
    @total = nil
  end
end
