module RPS
  module ComputerPlayers
    require_relative '../player'
    require_relative '../moves/moves'

    class PlayerHAL < Player
      def choose_move
        self.move = Moves.sample
        # Move strategy to be personalized...
      end

      private

      def set_name
        self.name = 'HAL'
      end
    end
  end
end
