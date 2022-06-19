require_relative '../oo_tic_tac_toe/common/common'
require_relative '../oo_tic_tac_toe/game_set'
require_relative 'participant_dealer'
require_relative 'participant_player'
require_relative 'twenty_one_game_table'

class TwentyOneGame
  attr_reader :participants

  def play
    display_welcome
    initialize_participants
    self.table = TwentyOneGameTable.new(participants)
    play_sets
    display_goodbye
  end

  private

  attr_accessor :table, :set

  def display_welcome
    Common.clear_console

    clubs_icon = StandardDeck::ICONS[:clubs]
    spades_icon = StandardDeck::ICONS[:spades]
    hearts_icon = StandardDeck::ICONS[:hearts]
    diamonds_icon = StandardDeck::ICONS[:diamonds]
    message = "#{clubs_icon} Welcome to Twenty-One! #{clubs_icon}"
    border = "#{spades_icon}#{
      hearts_icon.center(message.length - 2, diamonds_icon)
    }#{spades_icon}"

    puts border, message, border, Common::Messages.empty_line
  end

  def initialize_participants
    # Future feature: specify customizable participant/dealer strategies here.
    # - Select strategy and pass to `Participant...` class init.
    @participants = prompt_player_names.map do |name|
      ParticipantPlayer.new(name)
    end
    participants.push(ParticipantDealer.new)
  end

  def prompt_player_names
    [Common::Prompt.player_name]
    # Future Feature: Prompt for player count (up to 3) and names for each.
    # - Ensure unique names!
  end

  def play_sets
    self.set = GameSet.new(
      participants,
      win_score: 3,
      scoreboard_border_char: StandardDeck::ICONS[:diamonds]
    )

    loop do
      play_set
      break unless set.play_again?
    end
  end

  def play_set
    set.reset

    loop do
      table.play
      table.draw
      score_and_display_winners
      break if set.end?(display_results: true)
    end
  end

  def score_and_display_winners
    winners = table.winners
    set.round_winners(winners)
    table.display_winners(winners)
  end

  def display_goodbye
    puts 'Thank you for playing Twenty-One!'
  end
end
