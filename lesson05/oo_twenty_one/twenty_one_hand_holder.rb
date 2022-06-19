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

  def play_input_to_sym(input)
    INPUTS.rassoc(input)[0]
  end

  def inputs_display
    INPUTS.map do |key, value|
      "#{key.to_s.capitalize} (#{value})"
    end.join(' or ')
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
