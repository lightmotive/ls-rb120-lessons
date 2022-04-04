# frozen_string_literal: true

class Person
  attr_accessor :first_name, :last_name

  def initialize(first_name)
    self.first_name = first_name
    self.last_name = ''
  end

  def name
    return first_name if last_name.empty?

    "#{first_name} #{last_name}"
  end
end

# Modify the class definition from above to facilitate the following methods.

bob = Person.new('Robert')
p bob.name == 'Robert'                  # => 'Robert'
p bob.first_name == 'Robert'            # => 'Robert'
p bob.last_name == '' # => ''
bob.last_name = 'Smith'
p bob.name == 'Robert Smith'                  # => 'Robert Smith'
