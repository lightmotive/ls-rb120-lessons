# frozen_string_literal: true

require_relative 'twenty_one_hand'

# Abstract class: must inherit
class Participant
  INPUTS = { hit: 'h', stay: 's' }.freeze

  attr_reader :name, :is_dealer

  alias dealer? is_dealer

  def initialize(name, is_dealer: false)
    @name = name
    @is_dealer = is_dealer
    initialize_hand
  end

  def initialize_hand
    @hand = TwentyOneHand.new
  end

  def receive_card(card)
    hand.receive(card)
  end

  def total
    hand.total
  end

  def show_all_cards
    hand.show_all_cards
  end

  # Concrete implementation should return a key in `INPUTS`, e.g.,
  # `play_input_to_sym(string_input)`.
  def play
    raise AbstractNotImplementedError if instance_of?(Participant)
  end

  def play_input_to_sym(input)
    INPUTS.rassoc(input)[0]
  end

  def inputs_display
    INPUTS.map do |key, value|
      "#{key.to_s.capitalize} (#{value})"
    end.join(' or ')
  end

  def end_turn?
    return false if hand.total.nil?

    hand.busted? || hand.total == TwentyOneHand::WINNING_SCORE
  end

  def to_s
    "#{name}: #{hand}"
  end

  private

  attr_reader :hand
end
