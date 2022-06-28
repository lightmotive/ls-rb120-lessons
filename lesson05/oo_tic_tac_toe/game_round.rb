# frozen_string_literal: true

require_relative 'common/common'

# For games that have rounds with basic win/draw status and associated messages.
# Subclasses should typically implement a method that sets the private `@status`
# and `@winner` attributes.
class GameRound
  STATUS_MESSAGES = { win: '%<winner>s won the round!',
                      draw: 'Round draw!' }.freeze

  attr_reader :status, :winner

  def initialize
    @status = nil
    @winner = nil
  end

  def end?
    %i[win draw].include?(status)
  end

  def display_status
    Common::Messages.bordered_display(self.class::STATUS_MESSAGES[status] % to_hash, '-')
  end

  private

  attr_writer :status, :winner

  def to_hash
    { status: status, winner: winner }
  end
end
