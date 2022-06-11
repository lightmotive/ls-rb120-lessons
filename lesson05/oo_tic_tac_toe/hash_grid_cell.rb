require_relative 'abstract_not_implemented_error'

class HashGridCell
  attr_reader :key
  attr_accessor :value

  def initialize(key, value = nil)
    @key = key
    self.value = value
  end

  def display
    raise AbstractNotImplementedError
  end

  def empty?
    raise AbstractNotImplementedError
  end
end
