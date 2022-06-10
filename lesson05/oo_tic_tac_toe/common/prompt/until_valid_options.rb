module Common
  module Prompt
    class UntilValidOptions
      OPTIONS_DEFAULT = {
        prompt_with_format: nil,
        input_invalid_default_message: nil,
        get_input: nil,
        convert_input: nil,
        validate: nil
      }.freeze

      attr_reader :input_invalid_default_message

      def initialize(options = OPTIONS_DEFAULT)
        apply_options(options)
      end

      def prompt_with_format(msg)
        @prompt_with_format.call(msg)
      end

      # rubocop:disable Naming/AccessorMethodName
      def get_input
        @get_input.call
      end
      # rubocop:enable Naming/AccessorMethodName

      def convert_input(input)
        @convert_input.call(input)
      end

      # if input is invalid, raise ValidationError with custom message or
      # StandardError without message.
      # Raise ValidationError with helpful explanation (message) to prefix
      # original.
      def validate(converted_input)
        @validate.call(converted_input)
        nil
      end

      private

      def prompt_with_format=(options)
        @prompt_with_format = option_or_default(
          options[:prompt_with_format], ->(msg) { puts "-> #{msg}" }
        )
      end

      def input_invalid_default_message=(options)
        @input_invalid_default_message = option_or_default(
          options[:input_invalid_default_message], 'Invalid input.'
        )
      end

      def get_input=(options)
        @get_input = option_or_default(options[:get_input], -> { gets.strip })
      end

      def convert_input=(options)
        @convert_input = option_or_default(
          options[:convert_input], ->(input) { input }
        )
      end

      def validate=(options)
        @validate = option_or_default(
          options[:validate], ->(_input_converted) { nil }
        )
      end

      def apply_options(options)
        # need to call each instance method
        OPTIONS_DEFAULT.merge(options).each_key do |key|
          send("#{key}=".to_sym, options)
        end
      end

      def option_or_default(option, default)
        return default if option.nil?

        option
      end
    end
  end
end
