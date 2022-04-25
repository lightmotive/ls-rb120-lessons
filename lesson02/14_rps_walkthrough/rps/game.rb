module RPS
  require_relative 'player_human'
  require_relative 'player_computer'

  class Game
    attr_accessor :human, :computer

    def initialize
      display_welcome_message
      @human = PlayerHuman.new
      @computer = PlayerComputer.new
    end

    def display_welcome_message
      puts 'Welcome to Rock, Paper, Scissors!'
    end

    def display_goodbye_message
      puts 'Thanks for playing Rock, Paper, Scissors! Bye.'
    end

    def display_winner
      Player.print_moves(human, computer)
      puts human.move == computer.move ? tie_message : winner_message([human, computer].max_by(&:move))
    end

    def play_again?
      print 'Would you like to play again? (y/n) '
      gets.chomp.downcase.start_with?('y')
    end

    def play
      loop do
        human.choose_move
        computer.choose_move
        display_winner
        break unless play_again?
      end

      display_goodbye_message
    end

    private

    def tie_message
      "#{human.name} and #{computer.name} tied!"
    end

    def winner_message(winning_player)
      "#{winning_player.name} won!"
    end
  end
end

# not sure where "compare" goes yet
def compare(move1, move2); end
