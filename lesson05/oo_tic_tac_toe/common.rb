module Common
  def self.empty_line
    "\n"
  end

  def self.input_yes_or_no_is_yes?
    loop do
      input = gets.strip.downcase
      break true if input == 'y'
      break false if input == 'n'

      print "Please enter 'y' or 'n': "
    end
  end
end
