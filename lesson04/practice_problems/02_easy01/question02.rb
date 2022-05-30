# frozen_string_literal: true

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
    # `include [module]` within a class definition adds the module's methods
    # to the class.

    # With `#{self.class}` above, `self` refers to the instance of the class
    # that included the module. When an instance invokes an instance method,
    # `self` refers to the instance, and `self.class` returns the instance's
    # class.

    # Using interpolation automatically calls `to_s` on `self.class`, which
    # returns the class name.
  end
end

class Car
  include Speed

  def go_slow
    puts 'I am safe and driving slow.'
  end
end

class Truck
  include Speed

  def go_very_slow
    puts 'I am a heavy truck and like going very slow.'
  end
end

Car.new.go_fast
Truck.new.go_fast
