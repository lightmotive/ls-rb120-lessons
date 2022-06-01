class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts 'Hisssss!!!'
  end
end

meanie = AngryCat.new(1, 'Meanie')
chomps = AngryCat.new(6, 'Chomps')
