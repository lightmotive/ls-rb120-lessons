module RPS
  module Players
    require_relative '../moves/main'
    require_relative '../abstract_not_implemented_error'

    class Base
      attr_reader :move, :name

      def initialize
        set_name
      end

      # Abstract
      def choose_move
        raise AbstractNotImplementedError
      end

      def print_move
        Base.print_moves(self)
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

      # Abstract
      def set_name
        raise AbstractNotImplementedError
      end
    end
  end
end
