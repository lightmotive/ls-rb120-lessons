class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end
  
  # The methods defined on lines 6 and 10 can be simplified to 1 line:
  # `attr_accessor :type`

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end