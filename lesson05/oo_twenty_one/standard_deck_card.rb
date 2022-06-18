class StandardDeckCard
  ICONS = { face_down: "\u{1F0A0}" }.freeze

  attr_reader :suit, :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    @is_face_up = false
  end

  def face_down?
    !face_up?
  end

  def turn_up!
    self.is_face_up = true
  end

  def to_s
    face_down? ? ICONS[:face_down] : "#{rank}#{suit}"
  end

  private

  attr_accessor :is_face_up

  alias face_up? is_face_up
end
