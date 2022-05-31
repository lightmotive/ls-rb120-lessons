class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{type} of Bees Wax"
    # Here, we also want to use the `type` "getter" method instead of
    # referencing the instance variable directly, which yields more
    # maintainable code.
  end
end
