class Fruit
  def initialize(name)
    name = name
    # Line 3 reassigns the `name` variable (initialized with `name` parameter)
    # to itself without creating an instance variable.
  end
end

p Fruit.new('Apple')
# Notice that there's no `@name` (instance variable) in the output.

class Pizza
  def initialize(name)
    @name = name
    # Line 10 initializes an instance variable `name` and assigns it to the
    # `name` variable.
  end
end

p Pizza.new('Neapolitan')
# Notice there is an `@name` instance variable in the output.
