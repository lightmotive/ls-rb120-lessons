require_relative 'standard_deck_card'

class StandardDeck
  def initialize
    create
  end

  def pull_top_card
    array.shift
  end

  private

  attr_reader :array

  def create
    @array = []
    # Initialize StandardDeckCard instances from constants...
  end
end
