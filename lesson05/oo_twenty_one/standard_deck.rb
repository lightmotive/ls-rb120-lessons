# frozen_string_literal: true

require_relative 'standard_deck_card'

class StandardDeck
  ICONS = { spades: "\u{2660}", clubs: "\u{2663}", hearts: "\u{2665}",
            diamonds: "\u{2666}" }.freeze
  CARDS = {
    suits: [ICONS[:spades], ICONS[:clubs], ICONS[:hearts], ICONS[:diamonds]],
    ranks: {
      ace: 'A',
      jqk: %w[J Q K],
      numeric: (2..10).to_a
    }
  }.freeze

  attr_reader :auto_refill, :deck_count

  # - auto_refill: automatically generate a new deck and shuffle when empty.
  # - deck_count: generate and shuffle single decks, then stack.
  def initialize(auto_refill: false, deck_count: 1)
    @auto_refill = auto_refill
    @deck_count = deck_count
    create
  end

  def card_available?
    !array.empty?
  end

  def deal(count = 1)
    create if array.empty? && auto_refill
    raise StandardError, 'No more cards.' if array.empty?

    return array.shift if count == 1

    array.shift(count)
  end

  private

  attr_reader :array

  def create
    @array = []

    deck_count.times { @array.concat(full_deck.shuffle!) }

    nil
  end

  def full_deck
    deck = []

    ranks = [CARDS[:ranks][:ace]] +
            CARDS[:ranks][:jqk] +
            CARDS[:ranks][:numeric]

    CARDS[:suits].each do |suit|
      ranks.each { |rank| deck.push(StandardDeckCard.new(suit, rank)) }
    end

    deck
  end
end
