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
      Player.print_choices(human, computer)

      # There's a much better way to implement this, but I'll implement it
      # after the walkthrough:

      puts_winner = ->(player) { puts "#{player.name} won!" }
      game_tied = -> { puts "#{human.name} and #{computer.name} tied!" }

      case human.move
      when 'rock'
        if computer.move == 'scissors'
          puts_winner.call(human)
        else
          (computer.move == 'rock' ? game_tied.call : puts_winner.call(computer))
        end
      when 'paper'
        if computer.move == 'rock'
          puts_winner.call(human)
        else
          (computer.move == 'paper' ? game_tied.call : puts_winner.call(computer))
        end
      when 'scissors'
        if computer.move == 'paper'
          puts_winner.call(human)
        else
          (computer.move == 'scissors' ? game_tied.call : puts_winner.call(computer))
        end
      end
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
  end
end

# not sure where "compare" goes yet
def compare(move1, move2); end
