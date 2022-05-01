module RPS
  module ComputerPlayers
    require_relative 'player_hal'
    require_relative 'player_matrix'
    require_relative 'player_skynet'

    def self.sample
      const_get(constants.sample).new
    end
  end
end
