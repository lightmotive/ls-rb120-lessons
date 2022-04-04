# frozen_string_literal: true

class Person
  attr_accessor :name

  def initialize(name)
    self.name = name
  end
end

# Modify the class definition from above to facilitate the following methods.

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'
