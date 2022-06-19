require_relative 'twenty_one_hand'

module TwentyOneHandHolder
  def initialize_hand
    @hand = TwentyOneHand.new
  end

  def receive_card(card)
    hand.receive(card)
  end

  def total
    hand.total
  end

  def busted?
    hand.busted?
  end

  def show_all_cards
    hand.show_all_cards
  end

  def game_display
    "#{self}: #{hand}"
  end

  def end_turn?
    return false unless hand.total_calculable?

    hand.busted? || hand.total == TwentyOneHand::WINNING_SCORE
  end

  private

  attr_reader :hand
end
