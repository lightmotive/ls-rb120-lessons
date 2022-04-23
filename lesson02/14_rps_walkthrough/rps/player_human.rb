module RPS
  require_relative 'player'

  class PlayerHuman < Player
    def choose_move
      print "Your move, #{name} (#{MOVES.join(', ')})? "

      self.move = loop do
        move = gets.chomp.downcase
        break move if MOVES.include?(move)

        print 'Please enter a valid choice: '
      end
    end

    private

    def set_name
      print "What's your name? "
      self.name = loop do
        name = gets.strip
        break name unless name.empty?

        print 'What should I call you? '
      end
    end
  end
end
