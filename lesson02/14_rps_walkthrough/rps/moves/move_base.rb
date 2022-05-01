module RPS
  module Moves
    require_relative 'beats_move'

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

        "#{winning_move} #{winning_move.beats_move(losing_move).verb} #{losing_move}!"
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
  end
end
