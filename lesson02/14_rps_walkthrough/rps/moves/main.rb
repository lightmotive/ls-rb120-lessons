module RPS
  # RPS game moves.
  module Moves
    require_relative 'move'
    require_relative 'data'

    private_constant :BeatsMove, :Base, :Move, :DATA

    def self.create(move_base)
      Move.new(move_base)
      # If the game ever needed per-move customization ("power moves!"),
      # one could extend the `Move` class above with additional states and
      # behaviors.
      # Such flexibility demonstrates the importance of using a factory method
      # like this. It allows modifying object creation without requiring
      # extensive changes to existing code (as long as the interface is not
      # changed--SOLID, O: open to extension, closed to modification).
    end

    def self.create_from_string(string)
      matches = DATA.select do |move|
        move.string_match?(string)
      end
      return nil if matches.empty?

      create(matches.first)
    end

    def self.list_strings
      DATA.map(&:name)
    end

    def self.sample
      create(DATA.sample)
    end
  end
end
