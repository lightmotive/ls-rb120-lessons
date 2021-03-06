module RPS
  require_relative 'players/human'
  require_relative 'players/computer/main'
  require_relative 'score'
  require_relative 'moves/history'

  class Game
    attr_accessor :human, :computer
    attr_reader :score, :move_history

    def initialize(winning_score: 1)
      display_welcome_message
      @human = Players::Human.new
      @computer = Players::Computer.sample
      @score = Score.new(winning_score, [@human, @computer])
      @move_history = Moves::History.new(@human, @computer)
    end

    def display_move_history
      puts RPS.empty_line
      move_history.print
    end

    def play
      loop do
        play_round
        break unless play_again?

        score.initialize_game
      end

      display_move_history
      display_goodbye_message
    end

    private

    def name
      Moves.list_strings.join(', ').to_s
    end

    def display_welcome_message
      puts "Welcome to #{name}!"
    end

    def tie_message
      "#{human.name} and #{computer.name} tied!"
    end

    def win_message(winner, loser)
      "#{winner.move.win_explanation_vs(loser.move)} #{winner.name} won the round!"
    end

    def print_round_result
      Players::Base.print_moves(human, computer)

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
        move_history.record
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
      puts RPS.empty_line
      puts "Thanks for playing #{name}! Bye."
    end
  end
end

# not sure where "compare" goes yet
def compare(move1, move2); end
