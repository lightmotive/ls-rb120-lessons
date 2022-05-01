module RPS
  module Moves
    require_relative 'move_base'

    # Move for gameplay.
    class Move < MoveBase
      def initialize(move)
        super(move.key, move.data)
      end

      protected :key
      private :data
    end
  end
end
