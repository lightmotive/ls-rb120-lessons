module RPS
  module Moves
    require_relative 'move_base'

    # Move for gameplay.
    # Extend or inherit this class for stateful/complex moves.
    class Move < MoveBase
      def initialize(move)
        super(move.key, move.data)
      end

      protected :key
      private :data
    end
  end
end
