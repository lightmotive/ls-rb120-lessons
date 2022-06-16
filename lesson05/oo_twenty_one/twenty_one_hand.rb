require_relative 'standard_deck_hand'
require_relative 'standard_deck'

class TwentyOneHand < StandardDeckHand
  CARDS = StandardDeck::CARDS
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
    return @total = nil unless all_cards_face_up?

    value_with_ace11 = array.sum { |card| card_value(card, ace_value: 11) }
    return @total = value_with_ace11 if value_with_ace11 <= MAX_VALUE

    @total = array.sum { |card| card_value(card, ace_value: 1) }
  end
end
