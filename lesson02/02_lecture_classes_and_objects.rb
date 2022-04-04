# frozen_string_literal: true

# Given the below usage of the Person class, code the class definition.

class Person
  attr_accessor :name

  def initialize(name)
    self.name = name
  end
end

bob = Person.new('bob')
p bob.name == 'bob' # => 'bob'
bob.name = 'Robert'
p bob.name == 'Robert'                  # => 'Robert'
