# frozen_string_literal: true

require_relative 'participant'

class ParticipantDealer < Participant
  NAME = 'Dealer'
  HIT_UNTIL_MINIMUM_TOTAL = 17

  def initialize
    super(NAME, is_dealer: true)
  end

  def play
    return INPUTS.key(0) if hand.total < HIT_UNTIL_MINIMUM_TOTAL

    INPUTS.key(1)
  end
end
