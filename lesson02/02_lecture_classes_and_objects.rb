# frozen_string_literal: true

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    parse_full_name(name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(name)
    parse_full_name(name)
  end

  def ==(other)
    # - This would require a design discussion, but if the decision was to
    # compare based on name alone, this would work thanks to the logic wrapped
    # up in **String#==**:
    name == other.name
  end

  def to_s
    name
  end

  private

  def parse_full_name(name)
    name_parts = name.split
    self.first_name = name_parts.empty? ? '' : name_parts.first
    self.last_name = name_parts.size > 1 ? name_parts[1..-1].join(' ') : ''
  end
end

bob = Person.new('Robert')
p bob.name == 'Robert'                  # => 'Robert'
p bob.first_name == 'Robert'            # => 'Robert'
p bob.last_name == '' # => ''
bob.last_name = 'Smith'
p bob.name == 'Robert Smith' # => 'Robert Smith'

# Now create a smart name= method that can take just a first name or a full
# name, and knows how to set the first_name and last_name appropriately.
bob.name = 'John Adams'
bob.first_name            # => 'John'
bob.last_name             # => 'Adams'

bob.name = ''
p bob.first_name == ''
p bob.last_name == ''

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
# How can we compare the two objects?
p bob == rob # => true

bob = Person.new('Robert Smith')
p("The person's name is: #{bob}" == "The person's name is: Robert Smith")
