module RPS
  require_relative 'player'
  require_relative 'moves'

  class PlayerComputer < Player
    def choose_move
      self.move = Moves.sample
    end

    private

    def set_name
      self.name = ['The Matrix', 'Skynet', 'HAL'].sample
    end
  end
end
