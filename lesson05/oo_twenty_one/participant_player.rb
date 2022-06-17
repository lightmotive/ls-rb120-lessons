require_relative '../oo_tic_tac_toe/common/common'
require_relative 'participant'

class ParticipantPlayer < Participant
  def play
    play_input_to_sym(prompt_play)
  end

  private

  def prompt_play
    Common::Prompt.until_valid(
      "#{name}, your hand totals #{total}. #{inputs_display}?",
      convert_input: ->(input) { input.downcase },
      validate: lambda do |converted_input|
                  unless INPUTS.values.include?(converted_input)
                    raise ValidationError,
                          "Please enter either #{INPUTS.values.join(' or ')}."
                  end
                end
    )
  end
end
