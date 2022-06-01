class Cat
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def type_display # It's better to be more explicit with methods.
    "I am a #{type} cat."
  end
end

tabby = Cat.new('tabby')
puts tabby.type_display
