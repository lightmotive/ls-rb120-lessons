require_relative 'participant'

class ParticipantDealer < Participant
  MINIMUM_TOTAL = 17

  def initialize
    super(is_dealer: true)
  end

  def play
    # - Must `hit` while `total < MINIMUM_TOTAL`
    # - Can `stay` if `total >= MINIMUM_TOTAL`
  end
end
