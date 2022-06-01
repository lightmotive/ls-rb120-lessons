class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
    # Another way to write that:
    # @age += 1
    # However, that would go against the best practice of using methods to
    # access and update attributes.
  end
end
