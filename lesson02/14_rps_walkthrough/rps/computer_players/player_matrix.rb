module RPS
  module ComputerPlayers
    require_relative '../player'
    require_relative '../moves/moves'

    class PlayerMatrix < Player
      def choose_move
        self.move = Moves.sample
        # Move strategy to be personalized...
      end

      private

      def set_name
        self.name = 'The Matrix'
      end
    end
  end
end
