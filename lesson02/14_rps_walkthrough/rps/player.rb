module RPS
  class Player
    MOVES = %w[rock paper scissors].freeze

    attr_reader :move, :name

    def initialize
      @move = nil
      set_name
    end

    def choose_move
      raise NotImplementedError
    end

    def print_choice
      Player.print_choices(self)
    end

    def self.print_choices(*players)
      players.each { |player| puts "#{player.name} chose #{player.move}." }
    end

    private

    attr_writer :move, :name

    def set_name
      raise NotImplementedError
    end
  end
end
