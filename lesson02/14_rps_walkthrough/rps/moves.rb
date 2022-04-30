module RPS
  # List possible game moves.
  # Each move class should:
  # - Inherit `Move`.
  # - Override `self.to_s` if the class name is not user-friendly.
  # - Implement `initialize`: set `beats_moves` to Hash with data.
  module Moves
    # Base class for each possible game move.
    class Move
      include Comparable

      def initialize(beats_moves)
        @beats_moves = beats_moves
      end

      def self.to_s
        name.split('::').last
      end

      def <=>(other)
        return nil unless other.class.ancestors.include?(Move)
        return 0 if instance_of?(other.class)
        return 1 if beats_moves.key?(other.class)

        -1
      end

      def win_explanation_vs(losing_move)
        winning_move = self
        losing_move, winning_move = [self, other_move].sort unless beats_moves.key?(losing_move.class)

        "#{winning_move} #{winning_move.beats_moves[losing_move.class][:verb]} #{losing_move}."
      end

      def to_s
        self.class.to_s
      end

      alias eql? ==

      def hash
        to_s
      end

      protected

      attr_reader :beats_moves
    end

    private_constant :Move

    class Rock < Move
      def initialize
        super({ Scissors => { verb: 'crushes' },
                Lizard => { verb: 'crushes' } })
      end
    end

    class Paper < Move
      def initialize
        super({ Rock => { verb: 'covers' },
                Spock => { verb: 'disproves' } })
      end
    end

    class Scissors < Move
      def initialize
        super({ Paper => { verb: 'cut' },
                Lizard => { verb: 'decapitate' } })
      end
    end

    class Lizard < Move
      def initialize
        super({ Paper => { verb: 'eats' },
                Spock => { verb: 'poisons' } })
      end
    end

    class Spock < Move
      def initialize
        super({ Scissors => { verb: 'smashes' },
                Rock => { verb: 'vaporizes' } })
      end
    end

    def self.new_from_string(string)
      string = string.downcase
      matched_constants = constants.select { |c| const_get(c).to_s.downcase == string }
      return nil if matched_constants.empty?

      const_get(matched_constants.first).new
    end

    def self.list_strings
      constants.sort_by { |c| const_source_location(c).last }.map { |c| const_get(c).to_s }
    end

    def self.sample
      const_get(constants.sample).new
    end
  end
end

# Tradeoff note:
# one could eliminate the redundancy of defining a class for each move by
# dynamically adding `Move` classes, but that would require code that's harder
# to read and manage, e.g., https://stackoverflow.com/a/60426815/2033465.
#
# It might make sense if one wanted to generate classes that represent a larger
# data set, but then it would probably be better to redesign the solution to use
# data and a single class. In fact, that's probably best for the simple solution
# above! I'll do that next.
#
# Conclusion:
# Dynamically generating classes might be essential when developing solutions for
# complicated legacy code and certain types of libraries. Otherwise, one would
# probably choose a different design.
