module Moveable
  attr_accessor :speed, :heading
end

module LiquidFuel
  def initialize_fuel(km_traveled_per_liter, liters_of_fuel_capacity)
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicleLF
  include Moveable
  include LiquidFuel

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array

    initialize_fuel(km_traveled_per_liter, liters_of_fuel_capacity)
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicleLF
  def initialize
    # 4 tires are various tire pressures
    super([30, 30, 32, 32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicleLF
  def initialize
    # 2 tires are various tire pressures
    super([20, 20], 80, 8.0)
  end
end

class BoatLF
  include Moveable
  include LiquidFuel

  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls

    initialize_fuel(km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

class Catamaran < BoatLF
end

class Motorboat < BoatLF
  def initialize
    super(1, 1, 55, 13.0)
  end
end

auto = Auto.new
puts auto.range

motorcycle = Motorcycle.new
puts motorcycle.range

catamaran = Catamaran.new(2, 1, 40, 21.0)
puts catamaran.range

motorboat = Motorboat.new
puts motorboat.range
puts motorboat.propeller_count
