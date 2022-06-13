class Player
  attr_reader :name, :is_computer

  def initialize(name, is_computer)
    @name = name
    @is_computer = is_computer
  end

  def human?
    !is_computer
  end

  def computer?
    is_computer
  end

  def to_s
    name
  end
end
