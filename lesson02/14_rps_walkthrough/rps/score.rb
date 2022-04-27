module RPS
  class Score
    attr_reader :winning_score

    # `players` should be an array of objects that can be Hash keys and define
    #   `to_s` to return the player name.
    def initialize(winning_score, players)
      @winning_score = winning_score
      @players = players
      initialize_game
    end

    def initialize_game
      self.scores = ({})
      players.each { |player| scores[player] = 0 }
    end

    def increment(player, value: 1)
      scores[player] += value
    end

    def winner?(output_status: true)
      winning_player = self.winning_player

      if winning_player.nil?
        output_tally if output_status
        false
      else
        output_winner(winning_player) if output_status
        true
      end
    end

    def winning_player
      winners = scores.select { |_, score| score >= winning_score }
      return nil if winners.empty?

      winners.keys.first
    end

    def output_tally
      puts RPS.empty_line
      puts '** Scoreboard **'
      scores.sort_by { |_, score| -score }.each do |(player, score)|
        puts "#{player}: #{score}"
      end
    end

    private

    attr_accessor :scores
    attr_reader :players

    def output_winner(winning_player)
      puts RPS.empty_line
      puts "* #{winning_player} won the game with a score of #{scores[winning_player]}! *"
    end
  end
end
