require_relative 'standard_deck_hand'
require_relative 'standard_deck'

class TwentyOneHand < StandardDeckHand
  CARDS = StandardDeck::CARDS
  WINNING_SCORE = 21

  attr_reader :total

  def receive(card)
    super
    calculate_total
  end

  def show_all_cards
    super
    calculate_total
  end

  def total_calculable?
    all_cards_face_up?
  end

  def busted?
    return false unless total_calculable?

    total > WINNING_SCORE
  end

  def won?
    total == WINNING_SCORE
  end

  def to_s
    busted_str = ' - Busted!' if busted?
    total_str = "[#{total}#{busted_str}] " if total_calculable?
    "#{total_str}#{super}"
  end

  private

  def card_value(card, ace_value: 0)
    if CARDS[:ranks][:jqk].include?(card.rank)
      10
    elsif card.rank == CARDS[:ranks][:ace]
      ace_value
    else
      card.rank
    end
  end

  def calculate_total
    return @total = nil unless total_calculable?

    value_with_ace11 = array.sum { |card| card_value(card, ace_value: 11) }
    return @total = value_with_ace11 if value_with_ace11 <= WINNING_SCORE

    @total = array.sum { |card| card_value(card, ace_value: 1) }
  end
end
