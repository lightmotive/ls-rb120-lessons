class Oracle
  def predict_the_future
    'You will ' + choices.sample
  end

  def choices
    ['eat a nice lunch', 'take a nap soon', 'stay at work late']
  end
end

oracle = Oracle.new
puts oracle.predict_the_future
# Line 12 will return a string with "You will " followed by a random string
# selected from Oracle#choices' return value.
