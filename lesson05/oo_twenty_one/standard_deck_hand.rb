class StandardDeckHand
  ICONS = StandardDeck::ICONS

  def initialize
    @array = []
  end

  def receive(card)
    array.push(card)
  end

  def show_all_cards
    array.each(&:turn_up!)
  end

  def all_cards_face_up?
    array.none?(&:face_down?)
  end

  def to_string_ary
    array.map(&:to_s)
  end

  def to_s
    to_string_ary.join(' | ')
  end

  private

  attr_reader :array
end
