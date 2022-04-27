module RPS
  require_relative 'player_human'
  require_relative 'player_computer'
  require_relative 'score'

  class Game
    attr_accessor :human, :computer
    attr_reader :score

    def initialize(winning_score: 1)
      display_welcome_message
      @human = PlayerHuman.new
      @computer = PlayerComputer.new
      @score = Score.new(winning_score, [@human, @computer])
    end

    def play
      loop do
        play_round
        break unless play_again?

        score.initialize_game
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

    def win_message(winner, loser)
      "#{winner.move.win_explanation_vs(loser.move)} #{winner.name} won the round!"
    end

    def print_round_result
      Player.print_moves(human, computer)

      puts case human.move <=> computer.move
           when 0 then tie_message
           else
             loser, winner = [human, computer].sort_by(&:move)
             score.increment(winner)
             win_message(winner, loser)
           end
    end

    def play_round
      loop do
        puts RPS.empty_line
        human.choose_move
        computer.choose_move
        print_round_result
        break if score.winner?
      end
    end

    def play_again?
      puts RPS.empty_line
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
