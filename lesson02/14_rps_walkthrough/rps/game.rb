module RPS
  require_relative 'player'

  class Game
    attr_accessor :human, :computer

    def initialize
      @human = Player.new(PlayerTypes::Human)
      @computer = Player.new(PlayerTypes::Computer)
    end

    def display_welcome_message
      puts 'Welcome to Rock, Paper, Scissors!'
    end

    def display_goodbye_message
      puts 'Thanks for playing Rock, Paper, Scissors! Bye.'
    end

    def 

    def display_winner
      puts "You chose #{human.move}."
      puts "The computer chose #{computer.move}."

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
