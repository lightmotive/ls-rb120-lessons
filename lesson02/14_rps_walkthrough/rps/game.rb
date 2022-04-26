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

    def display_welcome_message
      puts 'Welcome to Rock, Paper, Scissors, Lizard, Spock!'
    end

    def tie_message
      "#{human.name} and #{computer.name} tied!"
    end

    def win_message(*players)
      loser, winner = players.sort_by(&:move)
      "#{winner.move.win_explanation_vs(loser.move)} #{winner.name} won!"
    end

    def display_winner
      Player.print_moves(human, computer)
      puts case human.move <=> computer.move
           when 0 then tie_message
           else win_message(human, computer)
           end
    end

    def play_again?
      print 'Would you like to play again? (y/n) '
      gets.chomp.downcase.start_with?('y')
    end

    def display_goodbye_message
      puts 'Thanks for playing Rock, Paper, Scissors! Bye.'
    end
  end
end

# not sure where "compare" goes yet
def compare(move1, move2); end
