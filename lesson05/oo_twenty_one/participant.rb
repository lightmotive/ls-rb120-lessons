# frozen_string_literal: true

require_relative 'twenty_one_hand'
require_relative 'twenty_one_hand_holder'

# Abstract class: must inherit
class Participant
  include TwentyOneHandHolder

  INPUTS = { hit: 'h', stay: 's' }.freeze

  attr_reader :name, :is_dealer

  alias dealer? is_dealer

  def initialize(name, is_dealer: false)
    @name = name
    @is_dealer = is_dealer
    initialize_hand
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

  def game_display
    "#{self}: #{hand}"
  end

  def to_s
    name
  end
end
