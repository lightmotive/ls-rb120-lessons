class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
    # `self` in an object (class instance) refers to the object.
    # One can get the object's class with `self.class`, which would return
    # `Cat` in this method.
  end
end
