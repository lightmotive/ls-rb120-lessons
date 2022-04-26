module RPS
  # List possible game moves.
  # Each move class should:
  # - Inherit `Move`.
  # - Override `self.to_s` if the class name is not user-friendly.
  # - Implement `self.beats_list` to return Array of classes that it beats.
  module Moves
    # Base class for each possible game move.
    class Move
      include Comparable

      def self.to_s
        name.split('::').last
      end

      def self.beats_list
        raise NotImplementedError
      end

      def to_s
        self.class.to_s
      end

      def <=>(other)
        return nil unless other.class.ancestors.include?(Move)
        return 0 if instance_of?(other.class)
        return 1 if self.class.beats_list.include?(other.class)

        -1
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

    def self.new_from_string(string)
      string = string.downcase
      matched_constants = constants.select { |c| const_get(c).to_s.downcase == string }
      return nil if matched_constants.empty?

      const_get(matched_constants.first).new
    end

    def self.list_strings
      constants.map { |c| const_get(c).to_s }
    end

    def self.sample
      const_get(constants.sample).new
    end
  end
end
