require_relative 'until_valid_options'

module Common
  module Prompt
    class UntilValid
      attr_reader :message

      def initialize(options = {
        prompt_with_format: nil,
        input_invalid_default_message: nil,
        get_input: nil,
        convert_input: nil,
        validate: nil
      })
        @options = UntilValidOptions.new(options)
      end

      # Returns the value from ::new(...options[:convert_input]...).
      def prompt(message)
        self.message = message

        options.prompt_with_format(self.message)
        loop_until_valid_input
      end

      private

      attr_reader :options
      attr_writer :message

      def loop_until_valid_input
        loop do
          value = options.convert_input(options.get_input)
          options.validate(value)
          break value
        rescue ValidationError => e
          options.prompt_with_format("#{e.message} #{message}")
        rescue StandardError
          options.prompt_with_format("#{options[:input_invalid_default_message]} #{message}")
        end
      end
    end
  end
end
