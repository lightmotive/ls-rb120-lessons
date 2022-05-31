class Cat
  @@cats_count = 0 # This initializes the `cats_count` class variable.
  # Class variables store data that's accessible across all instances.

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1 # Increment `cats_count` whenever `Cat` is instantiated.
  end

  def self.cats_count
    @@cats_count # Read how many times `Cat` was instantiated using `Cat.cats_count`.
  end
end
