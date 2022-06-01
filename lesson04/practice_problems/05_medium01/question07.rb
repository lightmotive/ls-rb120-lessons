class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def light_status # This method name is redundant; `status` is best here.
    "I have a brightness level of #{brightness} and a color of #{color}"
  end
end
