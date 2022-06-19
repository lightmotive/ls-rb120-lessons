require_relative '../oo_tic_tac_toe/common/common'
require_relative '../oo_tic_tac_toe/game_set'
require_relative 'standard_deck'
require_relative 'participant_dealer'
require_relative 'participant_player'

class Game
  attr_reader :deck, :participants

  def initialize
    @deck = StandardDeck.new
  end

  def play
    display_welcome
    initialize_participants
    play_sets
    display_goodbye
  end

  private

  attr_accessor :set

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
      play_round
      display_and_score_winners
      break if set.end?(display_results: true)
      # Feature suggestion: track and then draw all round boards with outcomes in set.
    end
  end

  def play_round
    participants.each(&:initialize_hand)
    deal_initial_cards
    draw

    participants.each { |participant| participant_turn(participant) }

    draw
  end

  def deal_initial_cards
    2.times do |card_idx|
      participants.each do |participant|
        deal(participant, face_up: card_idx.zero? || !participant.dealer?)
      end
    end
  end

  def participant_turn(participant)
    participant.show_all_cards if participant.dealer?

    return draw if participant.end_turn?

    loop do
      play = participant.play
      if play == :hit
        deal(participant, face_up: true)
        draw
      end
      break if play == :stay || participant.end_turn?
    end
  end

  def deal(participant, face_up: false)
    card = deck.pull_top_card
    card.turn_up! if face_up
    participant.receive_card(card)
  end

  def draw(clear_console: true)
    Common.clear_console if clear_console

    participant_lines = participants.map(&:game_display)

    Common::Messages.bordered_display(
      participant_lines, StandardDeck::ICONS[:diamonds], header: ' Table '
    )
    puts Common::Messages.empty_line
  end

  def display_and_score_winners
    winners = self.winners
    display_winners(winners)
    score_winners(winners)
  end

  def display_winners(winners)
    message =
      if winners.empty? then 'No winner this round.'
      elsif winners.size > 1
        "Tie round between #{winners.map(&:name).join(' and ')}."
      else
        "#{winners.first.name} won the round!"
      end

    puts "|*| #{message} |*|"
  end

  def score_winners(winners)
    winners.each do |winner|
      set.round_winner(winner)
    end
  end

  def players_by_highest_total
    participants.reject(&:busted?).sort_by { |participant| -participant.total }
  end

  def winners
    winners = players_by_highest_total
    return [] if winners.empty?

    winner_first = winners.first
    highest_total = winner_first.total

    [winner_first] + winners[1..].select do |winner|
      winner.total == highest_total
    end
  end

  def display_goodbye
    puts 'Thank you for playing Twenty-One!'
  end
end
