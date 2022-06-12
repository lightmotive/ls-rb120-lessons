require_relative 'common/common'

class GameSetStatus
  attr_reader :win_score, :winner

  def initialize(players, win_score = nil)
    @players = players
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
    Common::Messages.bordered_display(messages, '=', header: 'Scoreboard')
  end

  def display_enter_to_continue
    puts "Press enter to continue the game (first to #{win_score} wins)..."
    gets
  end

  def display_score_final
    puts Common::Messages.empty_line
    Common::Messages.bordered_display("#{winner} won the game!", '*')
  end

  private

  attr_reader :players, :scores
  attr_writer :winner

  # rubocop:disable Metrics/MethodLength
  def prompt_win_score
    Common::Prompt.until_valid(
      'Games to win (default: 5)?',
      convert_input: lambda do |input|
        return 5 if input.empty?

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
