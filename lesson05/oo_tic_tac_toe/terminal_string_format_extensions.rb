# frozen_string_literal: true

# Add color and formatting methods to `String` via refinement.
module TerminalStringFormatExtensions
  COLORS = { black: 30, red: 31, green: 32, brown: 33, blue: 34,
             magenta: 35, cyan: 36, gray: 37 }.freeze

  refine String do
    # Color code extension and original idea source:
    # https://stackoverflow.com/a/16363159/2033465

    # Modified implementation to maximize clarity and maintainability.

    # Define colors:
    COLORS.each do |key, code|
      # Colors:
      define_method(key) { "\e[#{code}m#{self}\e[0m" }

      # Background colors:
      define_method("bg_#{key}") { "\e[#{code + 10}m#{self}\e[0m" }
    end

    def bold
      "\e[1m#{self}\e[22m"
    end

    def italic
      "\e[3m#{self}\e[23m"
    end

    def underline
      "\e[4m#{self}\e[24m"
    end

    def blink
      "\e[5m#{self}\e[25m"
    end

    def reverse_color
      "\e[7m#{self}\e[27m"
    end
  end
end
