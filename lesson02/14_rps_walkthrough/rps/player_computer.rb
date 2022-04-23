module RPS
  require_relative 'player'

  class PlayerComputer < Player
    def choose_move
      self.move = MOVES.sample
    end

    private

    def set_name
      self.name = ['The Matrix', 'Skynet,', 'HAL'].sample
    end
  end
end
