module RPS
  module Players
    module Computer
      class Matrix < Base
        def choose_move
          # Move strategy to be personalized...
          self.move = Moves.sample
        end

        private

        def set_name
          self.name = 'The Matrix'
        end
      end
    end
  end
end
