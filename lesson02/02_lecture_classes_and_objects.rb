# frozen_string_literal: true

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    self.name = name
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(name)
    name_parts = name.split
    self.first_name = name_parts.empty? ? '' : name_parts.first
    self.last_name = name_parts.size > 1 ? name_parts[1..-1] : ''
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
