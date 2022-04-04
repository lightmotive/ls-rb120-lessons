# frozen_string_literal: true

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    name_parts = name.split
    self.first_name = name_parts.first
    self.last_name = name_parts.size > 1 ? name_parts[1..-1] : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end
end

# Modify the class definition from above to facilitate the following methods.

bob = Person.new('Robert')
p bob.name == 'Robert'                  # => 'Robert'
p bob.first_name == 'Robert'            # => 'Robert'
p bob.last_name == '' # => ''
bob.last_name = 'Smith'
p bob.name == 'Robert Smith'                  # => 'Robert Smith'
