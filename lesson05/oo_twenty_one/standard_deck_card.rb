class StandardDeckCard
  attr_accessor :is_face_up
  attr_reader :suit, :rank

  alias face_up? is_face_up

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def face_down?
    !face_up?
  end

  def to_s
    # different display depending on is_face_up value...
  end
end
