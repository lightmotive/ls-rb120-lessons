# frozen_string_literal: true

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end

  def fetch
    'fetching!'
  end
end

teddy = Dog.new
puts teddy.speak # => "bark!"
puts teddy.swim           # => "swimming!"

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

johnny = Bulldog.new
puts johnny.swim
