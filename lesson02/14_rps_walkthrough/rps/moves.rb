module RPS
  # List possible game moves.
  # Each move class should:
  # - Inherit `Move`.
  # - Override `self.to_s` if the class name is not user-friendly.
  # - Implement `self.beats_list` to return Array of Moves classes that the move beats.
  module Moves
    # Base class for each possible game move.
    class Move
      extend Comparable

      def self.to_s
        name.split('::').last
      end

      def self.<=>(other)
        return nil unless other.ancestors.include?(Move)
        return 0 if self == other
        return 1 if beats_list.include?(other)

        -1
      end

      def self.beats_list
        raise NotImplementedError
      end
    end

    private_constant :Move

    class Rock < Move
      def self.beats_list
        [Scissors]
      end
    end

    class Paper < Move
      def self.beats_list
        [Rock]
      end
    end

    class Scissors < Move
      def self.beats_list
        [Paper]
      end
    end

    def self.string_to_class(string)
      string = string.downcase
      matched_constants = constants.select { |c| const_get(c).to_s.downcase == string }
      return nil if matched_constants.empty?

      const_get(matched_constants.first)
    end

    def self.list_strings
      constants.map { |c| const_get(c).to_s }
    end

    def self.sample
      const_get(constants.sample)
    end
  end
end
