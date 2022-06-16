# frozen_string_literal: true

require_relative 'twenty_one_hand'

# Abstract class: must inherit
class Participant
  PLAY_HIT = 'hit'
  PLAY_STAY = 'stay'

  attr_reader :name, :is_dealer, :total

  alias dealer? is_dealer

  def initialize(name, is_dealer: false)
    @name = name
    @is_dealer = is_dealer
    @hand = TwentyOneHand.new
  end

  def receive_card(card)
    hand.receive_card(card)
    calculate_total
  end

  # Concrete implementation should return either `PLAY_HIT` or `PLAY_STAY`
  def play
    raise AbstractNotImplementedError if instance_of?(Participant)
  end

  def to_s
    "#{name}: #{hand}"
  end

  private

  attr_reader :hand
end