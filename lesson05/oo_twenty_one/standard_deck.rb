# frozen_string_literal: true

require_relative 'standard_deck_card'

class StandardDeck
  ICONS = { spades: "\u{2660}", clubs: "\u{2663}", hearts: "\u{2665}",
            diamonds: "\u{2666}", face_down: "\u{1F0A0}" }.freeze
  CARDS = {
    suits: [ICONS[:spades], ICONS[:clubs], ICONS[:hearts], ICONS[:diamonds]],
    ranks: {
      ace: 'A',
      jqk: %w[J Q K],
      numeric: (2..10).to_a
    }
  }.freeze

  def initialize
    create
    shuffle!
  end

  def shuffle!
    array.shuffle!
  end

  def pull_top_card
    array.shift
  end

  private

  attr_reader :array

  def create
    @array = []

    ranks = [CARDS[:ranks][:ace]] +
            CARDS[:ranks][:jqk] +
            CARDS[:ranks][:numeric]

    CARDS[:suits].each do |suit|
      ranks.each { |rank| @array.push(StandardDeckCard.new(suit, rank)) }
    end

    nil
  end
end
