module RPS
  require_relative 'player'

  class Game
    attr_accessor :human, :computer

    def initialize
      display_welcome_message

      @human = Player.new(PlayerTypes::Human)
      @computer = Player.new(PlayerTypes::Computer)
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

      human_won = -> { puts 'You won!' }
      human_lost = -> { puts 'You lost.' }
      game_tied = -> { puts 'Tie!' }

      case human.move
      when 'rock'
        if computer.move == 'scissors'
          human_won.call
        else
          (computer.move == 'rock' ? game_tied.call : human_lost.call)
        end
      when 'paper'
        if computer.move == 'rock'
          human_won.call
        else
          (computer.move == 'paper' ? game_tied.call : human_lost.call)
        end
      when 'scissors'
        if computer.move == 'paper'
          human_won.call
        else
          (computer.move == 'scissors' ? game_tied.call : human_lost.call)
        end
      end
    end

    def play_again?
      print 'Would you like to play again? (y/n) '
      gets.chomp.downcase.start_with?('y')
    end

    def play
      loop do
        human.choose
        computer.choose
        display_winner
        break unless play_again?
      end

      display_goodbye_message
    end
  end
end

# not sure where "compare" goes yet
def compare(move1, move2); end
