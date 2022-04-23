module RPS
  require_relative 'player_types'

  class Player
    MOVES = %w[rock paper scissors].freeze

    attr_reader :move, :name

    def initialize(type)
      @type = type
      @move = nil
      set_name
    end

    def choose_move
      if human?
        print "Your move, #{name} (#{MOVES.join(', ')})? "
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

    def print_choice
      Player.print_choices(self)
    end

    def self.print_choices(*players)
      players.each { |player| puts "#{player.name} chose #{player.move}." }
    end

    private

    attr_writer :move, :name

    def set_name
      return self.name = 'Computer' unless human?

      print "What's your name? "
      self.name = gets.strip
    end
  end
end
