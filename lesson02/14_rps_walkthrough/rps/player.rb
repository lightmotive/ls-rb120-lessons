module RPS
  require_relative 'player_types'

  class Player
    MOVES = %w[rock paper scissors].freeze

    attr_reader :move

    def initialize(type)
      @type = type
      @move = nil
    end

    def choose
      if human?
        print "Your move (#{MOVES.join(', ')})? "
        self.move = loop do
          move = gets.chomp.downcase
          break move if MOVES.include?(move)

          print 'Please enter a valid choice: '
        end
      else
        self.move = MOVES.sample
      end
    end

    def human?
      @type == PlayerTypes::Human
    end

    private

    attr_writer :move
  end
end
