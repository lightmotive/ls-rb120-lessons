require_relative 'common/common'

# Other game programs reference this file. To be migrated to a private Gem...
class GameSet
  attr_reader :win_score, :scoreboard_border_char, :winner

  def initialize(players, win_score: 3, scoreboard_border_char: '=')
    @players = players
    @scoreboard_border_char = scoreboard_border_char
    reset(win_score)
  end

  def reset(win_score = nil)
    @win_score = win_score.nil? ? prompt_win_score : win_score
    @scores = Hash.new(0)
  end

  def end?(display_results: false)
    self.winner = determine_winner

    result = !winner.nil?
    return result unless display_results

    result ? display_score_final : display_score_with_pause

    result
  end

  def round_winner(player)
    scores[player] += 1
  end

  def score(player)
    scores[player]
  end

  def determine_winner
    players.select { |player| score(player) == win_score }.first
  end

  def players_by_top_score
    players_by_score = players.sort_by { |player| score(player) }
    players_by_score.reverse
  end

  def display_score
    messages = players_by_top_score.map do |player|
      "#{player}: #{score(player)}"
    end

    puts Common::Messages.empty_line
    Common::Messages.bordered_display(
      messages, scoreboard_border_char, header: 'Scoreboard'
    )
  end

  def display_enter_to_continue
    puts "Press enter to continue the game (first to #{win_score} wins)..."
    gets
  end

  def display_score_final
    puts Common::Messages.empty_line
    Common::Messages.bordered_display("#{winner} won the game with a score of #{score(winner)}!", '*')
  end

  def play_again?
    puts Common::Messages.empty_line
    Common::Prompt.yes_or_no_is_yes?('Would you like to play again?')
  end

  private

  attr_reader :players, :scores
  attr_writer :winner

  # rubocop:disable Metrics/MethodLength
  def prompt_win_score
    Common::Prompt.until_valid(
      "Round win count to win game? (default: #{win_score})",
      convert_input: lambda do |input|
        return win_score if input.empty?

        input.to_i
      end,
      validate: lambda do |converted_input|
                  unless converted_input.positive?
                    raise ValidationError, 'Please enter a number greater than 0 ' \
                                           'or hit enter to accept the default.'
                  end
                end
    )
  end
  # rubocop:enable Metrics/MethodLength

  def display_score_with_pause
    display_score
    display_enter_to_continue
  end
end
