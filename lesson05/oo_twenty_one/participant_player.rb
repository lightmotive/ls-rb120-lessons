require_relative 'participant'

class ParticipantPlayer < Participant
  def initialize(name)
    super(name)
  end

  def play
    # human player chooses to either hit or stay
  end
end
