module RPS
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
  end
end
