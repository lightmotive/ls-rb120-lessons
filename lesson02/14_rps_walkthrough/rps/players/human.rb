module RPS
  module Players
    require_relative 'base'

    class Human < Base
      def choose_move
        moves_list_strings = Moves.list_strings.map(&:downcase)

        print "Your move, #{name} (#{moves_list_strings.join(', ')})? "

        self.move = loop do
          move = Moves.create_from_string(gets.chomp.downcase)
          break move unless move.nil?

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
end
