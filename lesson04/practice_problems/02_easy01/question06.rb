class Cube
  attr_reader :volume

  def initialize(volume)
    @volume = volume
  end

  def to_s
    "#{self.class} with volume of #{volume}"
  end
end

cube = Cube.new(9)

puts cube.to_s
puts cube.class.to_s
puts cube.class.name
puts cube.class.class
p cube.class.class.ancestors
p cube.methods.sort
p cube.method(:volume).owner
p cube.method(:to_s).owner # => `Kernel` when object doesn't implement `to_s`.
# Why isn't `to_s`'s owner `Object` when not implemented?
p cube.to_s
p cube.class.ancestors
