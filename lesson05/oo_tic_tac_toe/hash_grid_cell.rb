require_relative 'abstract_not_implemented_error'

class HashGridCell
  attr_reader :key

  def initialize(key)
    @key = key
  end

  def display
    raise AbstractNotImplementedError
  end

  def empty?
    raise AbstractNotImplementedError
  end
end
