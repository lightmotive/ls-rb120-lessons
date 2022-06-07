# frozen_string_literal: true

require_relative 'validation_error'

module Common
  def self.clear_console
    system('clear')
  end

  module Prompt
    # => Input with options applied.
    # Commonly specified options:
    # - get_input: lambda => input
    # - convert_input: lambda(input) => converted_input
    # - validate: lambda(converted_input) => nil (raise exception as needed)
    # Commonly default options:
    # - prompt_with_format: lambda(msg) => "-> #{msg}"
    # - input_invalid_default_message: => "Invalid input."
    #   - That displays in front of the error message.
    def self.until_valid(message, options = UntilValidOptions::OPTIONS_DEFAULT)
      UntilValid.new(options).prompt(message)
    end

    def self.yes_or_no(message)
      UntilValid.new(
        get_input: -> { gets.strip },
        convert_input: ->(input) { input.downcase },
        validate: lambda do |input|
          raise ValidationError, 'Please enter either Y for yes or N for no.' unless %w[y n].include?(input)
        end
      ).prompt("#{message} (Y/N)")
    end

    def self.yes_or_no_is_yes?(message)
      Prompt.yes_or_no(message) == 'y'
    end

    def self.enter_to_continue(message)
      puts message
      gets
    end

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
        apply_options(OPTIONS_DEFAULT.merge(options))
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
        @get_input = option_or_default(
          options[:get_input], -> { gets.strip }
        )
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
        options.each_key { |key| send("#{key}=".to_sym, options) }
      end

      def option_or_default(option, default)
        return default if option.nil?

        option
      end
    end

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

    private_constant :UntilValidOptions, :UntilValid
  end

  module Messages
    def self.empty_line
      "\n"
    end

    def messages_bordered_display(messages, border_char, header: '')
      messages = [messages] unless messages.is_a?(Array)

      max_length = messages.max_by(&:length).length
      max_length = header.length + 4 if header.length >= max_length

      border = border_char.ljust(max_length, border_char)

      puts(header.empty? ? border : header.center(max_length, border_char))
      messages.each { |message| puts message }
      puts border
    end
  end
end
