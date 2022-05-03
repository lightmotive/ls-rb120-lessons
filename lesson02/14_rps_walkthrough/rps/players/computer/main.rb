module RPS
  module Players
    module Computer
      require_relative '../base'
      require_relative 'hal'
      require_relative 'matrix'
      require_relative 'skynet'

      def self.sample
        const_get(constants.sample).new
      end
    end
  end
end
