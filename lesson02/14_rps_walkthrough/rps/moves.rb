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
        super
        @beats_moves = { Scissors => { verb: 'crushes' },
                         Lizard => { verb: 'crushes' } }
      end
    end

    class Paper < Move
      def initialize
        super
        @beats_moves = { Rock => { verb: 'covers' },
                         Spock => { verb: 'disproves' } }
      end
    end

    class Scissors < Move
      def initialize
        super
        @beats_moves = { Paper => { verb: 'cut' },
                         Lizard => { verb: 'decapitate' } }
      end
    end

    class Lizard < Move
      def initialize
        super
        @beats_moves = { Paper => { verb: 'eats' },
                         Spock => { verb: 'poisons' } }
      end
    end

    class Spock < Move
      def initialize
        super
        @beats_moves = { Scissors => { verb: 'smashes' },
                         Rock => { verb: 'vaporizes' } }
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
