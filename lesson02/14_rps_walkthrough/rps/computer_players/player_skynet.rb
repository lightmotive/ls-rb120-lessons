module RPS
  module ComputerPlayers
    require_relative '../player'
    require_relative '../moves/moves'

    class PlayerSkynet < Player
      def choose_move
        self.move = Moves.sample
        # Move strategy to be personalized...
      end

      private

      def set_name
        self.name = 'Skynet'
      end
    end
  end
end
