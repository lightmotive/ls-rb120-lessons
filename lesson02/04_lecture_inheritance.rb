# frozen_string_literal: true

class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Animal
  def speak
    'ruff!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

teddy = Dog.new
puts teddy.speak # => "bark!"
puts teddy.swim # => "swimming!"

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

johnny = Bulldog.new
puts johnny.swim

# ***

class Cat < Animal
  def speak
    'meow'
  end
end

kitty = Cat.new
puts kitty.run
puts kitty.speak
