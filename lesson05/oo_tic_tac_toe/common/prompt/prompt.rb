require_relative 'until_valid'

module Common
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

    private_constant :UntilValidOptions, :UntilValid
  end
end
