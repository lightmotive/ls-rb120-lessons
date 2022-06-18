# frozen_string_literal: true

require_relative 'participant'

class ParticipantDealer < Participant
  NAME = 'Dealer'
  HIT_UNTIL_MINIMUM_TOTAL = 17

  def initialize
    super(NAME, is_dealer: true)
  end

  def play
    return play_input_to_sym(INPUTS[:hit]) if hand.total < HIT_UNTIL_MINIMUM_TOTAL

    play_input_to_sym(INPUTS[:stay])
  end
end
