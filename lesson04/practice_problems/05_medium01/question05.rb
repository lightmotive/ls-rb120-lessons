class KrispyKreme
  attr_reader :filling_type, :glazing

  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def filling_type_display
    return 'Plain' if filling_type.nil?

    filling_type
  end

  def glazing_display
    return '' if glazing.nil?

    " with #{glazing}"
  end

  def to_s
    filling_type_display + glazing_display
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new('Vanilla', nil)
donut3 = KrispyKreme.new(nil, 'sugar')
donut4 = KrispyKreme.new(nil, 'chocolate sprinkles')
donut5 = KrispyKreme.new('Custard', 'icing')

p donut1.to_s == 'Plain'
p donut2.to_s == 'Vanilla'
p donut3.to_s == 'Plain with sugar'
p donut4.to_s == 'Plain with chocolate sprinkles'
p donut5.to_s == 'Custard with icing'
