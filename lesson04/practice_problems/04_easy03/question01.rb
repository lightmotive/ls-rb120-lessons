class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet('Hello')
  end

  def self.hi
    new.hi
  end
end

Hello.hi

class Goodbye < Greeting
  def bye
    greet('Goodbye')
  end
end

# case 1:
hello = Hello.new # new instance of `Hello`
hello.hi # => Hello\n

# case 2:
hello = Hello.new
hello.bye # NoMethodError

# case 3:
hello = Hello.new
hello.greet # ArgumentError

# case 4:
hello = Hello.new
hello.greet('Goodbye') # => Goodbye\n

# case 5:
Hello.hi # NoMethodError
