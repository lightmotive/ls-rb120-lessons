module RPS
  class Player
    attr_reader :move, :name

    def initialize
      set_name
    end

    def choose_move
      raise NotImplementedError
    end

    def print_move
      Player.print_moves(self)
    end

    def self.print_moves(*players)
      puts '---'
      players.each { |player| puts "#{player.name} chose #{player.move}." }
      puts '---'
    end

    alias eql? ==

    def hash
      name.hash
    end

    def to_s
      name
    end

    private

    attr_writer :move, :name

    def set_name
      raise NotImplementedError
    end
  end
end
