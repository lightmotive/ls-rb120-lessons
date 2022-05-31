class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count # Here, `self` refers to the class (definition).
    @@cats_count
  end
end
