class Oracle
  def predict_the_future
    'You will ' + choices.sample
  end

  def choices
    ['eat a nice lunch', 'take a nap soon', 'stay at work late']
  end
end

class RoadTrip < Oracle
  def choices
    ['visit Vegas', 'fly to Fiji', 'romp in Rome']
  end
end

trip = RoadTrip.new
puts trip.predict_the_future
# Line 18 invokes the `predict_the_future` method inherited from `Oracle`.
# That method invokes the `choices` method in `RoadTrip`, which overrides
# `choices` in `Oracle`.
