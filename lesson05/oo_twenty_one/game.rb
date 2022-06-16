require_relative 'standard_deck'
require_relative 'participant_dealer'
require_relative 'participant_player'

class Game
  attr_reader :deck, :participants

  def initialize
    # Initialize deck and participants
    # Deal initial cards
    # ...
  end

  private

  def deal_initial_cards
    # deal to all participants
    # different behavior for dealer vs player
  end

  def participants_play
    # - iterate through `participants` who `play` until bust, win, or stay
    #   - `hit(player)` if `player.play == hit`
    # - dealer plays last
  end

  def hit(participant)
    # deal 1 card to participant
  end

  def draw
    # - iterate through `participants` to displays cards and values
  end
end
