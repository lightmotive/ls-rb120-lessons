module RPS
  module Players
    module Computer
      class Skynet < Base
        def choose_move
          # Move strategy to be personalized...
          self.move = Moves.sample
        end

        private

        def set_name
          self.name = 'Skynet'
        end
      end
    end
  end
end
