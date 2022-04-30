module RPS
  # RPS game moves.
  module Moves
    # Data for how one move beats another.
    class BeatsMove
      attr_reader :verb

      def initialize(key, beats_key, data)
        @key = key
        @beats_key = beats_key
        @verb = data[:verb].dup
      end
    end

    # Base for game move.
    class MoveBase
      include Comparable

      attr_reader :key, :name, :beats_moves

      def initialize(key, data)
        @key = key
        @data = data
        set_name
        initialize_beats_moves
      end

      def to_s
        name
      end

      def string_match?(string)
        string.downcase == name.downcase
      end

      def beats?(other)
        !beats_move(other).nil?
      end

      def <=>(other)
        return nil unless other.class.ancestors.include?(MoveBase)
        return 0 if key == other.key
        return 1 if beats?(other)

        -1
      end

      def sort_with(other)
        [self, other].sort
      end

      def win_explanation_vs(other)
        return '' if self == other

        losing_move, winning_move = sort_with(other)

        "#{winning_move} #{winning_move.beats_move(losing_move).verb} #{losing_move}."
      end

      alias eql? ==

      def hash
        key.hash
      end

      protected

      def beats_move(other)
        beats_moves[other.key]
      end

      def data
        @data.dup
        # Current structure would warrant deep copy above, which is beyond the
        # scope of this exercise.
      end

      private

      def set_name
        @name = data.key?(:name) ? data[:name] : key.to_s
      end

      def initialize_beats_moves
        @beats_moves = data[:beats].map do |beats_key, data|
          [beats_key, BeatsMove.new(key, beats_key, data)]
        end.to_h
      end
    end

    # Specify `:name` in Hash object passed to `Move` to override symbol-based
    # name; `:name` is necessary only if symbol.to_s is not suitable for UX.
    MOVES = [MoveBase.new(:Crystal, { beats: { Swords: { verb: 'relocates' },
                                               Dragon: { verb: 'relocates' } } }),
             MoveBase.new(:Parchment, { beats: { Crystal: { verb: 'covers' },
                                                 Mage: { verb: 'disproves' } } }),
             MoveBase.new(:Swords, { beats: { Parchment: { verb: 'cut' },
                                              Dragon: { verb: 'decapitate' } } }),
             MoveBase.new(:Mage, { beats: { Swords: { verb: 'melts' },
                                            Crystal: { verb: 'crushes' } } }),
             MoveBase.new(:Dragon, { beats: { Parchment: { verb: 'burns' },
                                              Mage: { verb: 'eats' } } })].freeze

    # Standard moves:
    # [MoveBase.new(:Rock, { beats: { Scissors: { verb: 'crushes' },
    #                                             Lizard: { verb: 'crushes' } } }),
    #              MoveBase.new(:Paper, { beats: { Rock: { verb: 'covers' },
    #                                              Spock: { verb: 'disproves' } } }),
    #              MoveBase.new(:Scissors, { beats: { Paper: { verb: 'cut' },
    #                                                 Lizard: { verb: 'decapitate' } } }),
    #              MoveBase.new(:Spock, { beats: { Scissors: { verb: 'smashes' },
    #                                              Rock: { verb: 'vaporizes' } } }),
    #              MoveBase.new(:Lizard, { beats: { Paper: { verb: 'eats' },
    #                                               Spock: { verb: 'poisons' } } })].freeze

    # Move for gameplay.
    class Move < MoveBase
      def initialize(move)
        super(move.key, move.data)
      end

      protected :key
      private :data
    end

    private_constant :BeatsMove, :MoveBase, :Move, :MOVES

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
      matches = MOVES.select do |move|
        move.string_match?(string)
      end
      return nil if matches.empty?

      create(matches.first)
    end

    def self.list_strings
      MOVES.map(&:name)
    end

    def self.sample
      create(MOVES.sample)
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
# above! Done with this commit.
#
# Conclusion:
# Dynamically generating classes might be essential when developing solutions for
# complicated legacy code and certain types of libraries. Otherwise, one would
# probably choose a different design.
