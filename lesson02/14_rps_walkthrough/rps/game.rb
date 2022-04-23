module RPS
  require_relative 'player'

  class Game
    attr_accessor :human, :computer

    def initialize
      @human = Player.new
      @computer = Player.new
    end

    def display_welcome_message
      puts 'Welcome to Rock, Paper, Scissors!'
    end

    def display_goodbye_message
      puts 'Thanks for playing Rock, Paper, Scissors! Bye.'
    end

    def play
      display_welcome_message
      human.choose
      computer.choose
      display_winner
      display_goodbye_message
    end
  end
end

# not sure where "compare" goes yet
def compare(move1, move2); end
