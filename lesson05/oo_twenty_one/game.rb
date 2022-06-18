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
    @participants.push(ParticipantDealer.new)
  end

  def play_sets
    self.set = GameSet.new(
      participants, win_score: 3,
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
      determine_winners
      break if set.end?(display_results: true)
      # Feature suggestion: track and then draw all round boards with outcomes in set.
    end
  end

  def play_round
    # ...
  end

  def determine_winners
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

  def prompt_player_names
    [Common::Prompt.player_name]
    # Future Feature: Prompt for player count (up to 3) and names for each.
    # - Ensure unique names!
  end

  def deal_initial_cards
    # deal to all participants
    # different behavior for dealer vs player
  end

  def participants_play
    # - iterate through `participants` who `play` until bust, win, or stay
    #   - `hit(player)` if `player.play == hit`
    # - dealer plays last
  end

  def hit(participant)
    # deal 1 card to participant
  end

  def draw
    # - iterate through `participants` to displays cards and values
  end

  def display_goodbye
    puts 'Thank you for playing Twenty-One!'
  end
end

# Procedural code to be migrated to OOP:
# **************************************

# frozen_string_literal: true

# require_relative '../../ruby-common/prompt'
# require_relative '../../ruby-common/validation_error'
# require_relative '../../ruby-common/messages'
#
# SCORE_TO_WIN_SET = 5 # We could allow player(s) to specify that score.
#
# * Cards *
#
# def cards_create
#   # migrated to `StandardDeck`
# end
#
# def card_value(card, ace_value: 0)
#   # migrated to `TwentyOneHand#card_value` (private)
# end
#
# def all_cards_face_up?(cards)
#   # migrated to `StandardDeckHand#all_cards_face_up?`
# end
#
# def cards_value(cards)
#   # migrated to `TwentyOneHand#calculate_total`
# end
#
# def cards_for_display(cards)
#   # migrated to `StandardDeckHand#to_s`
# end
#
# * Game State *
#
# def game_state_create(players)
#   # migrated to `Game#initialize` (refactored)
# end
#
# def update_player_cards_value!(player)
#   player[:cards_value] = cards_value(player[:cards])
# end
#
# def deal_card!(player, game_state, face_up: true)
#   cards = player[:cards]
#   cards.push(game_state[:deck].shift.merge({ face_up: face_up }))
#   update_player_cards_value!(player)
# end
#
# def deal_table!(game_state)
#   2.times do |card_idx|
#     participants.each do |player|
#       face_up = (!player[:is_dealer]) || card_idx == 0
#       deal_card!(player, game_state, face_up: face_up)
#     end
#   end
# end
#
# * Players *
#
# def welcome_display
#   # migrated to `Game#display_welcome`
# end
#
# def players_prompt(player_strategy)
#   # migrated to `Game#initialize_participants` and `Game#prompt_player_names`
# end
#
# def players_append_dealer!(players, dealer_strategy)
#   # migrated to `Game#initialize_participants`
# end
#
# def busted?(cards_value)
#   # migrated to `TwentyOneHand#busted?`
# end
#
# def end_turn?(player)
#   value = player[:cards_value]
#   return false if value.nil?
#
#   busted?(value) || value == WINNING_SCORE
# end
#
# Unnecessary method: dealer is always last:
# # def players_dealer_last(game_state)
# #   players = game_state.dig(:table, :players)
# #   players.sort_by { |player| player[:is_dealer] ? 1 : 0 }
# # end
#
# def turn_cards_up!(player)
#   player[:cards].each { |card| card[:face_up] = true }
#   update_player_cards_value!(player)
# end
#
# def turn!(player, game_state)
#   turn_cards_up!(player) if player[:is_dealer]
#
#   return game_redraw(game_state) if end_turn?(player)
#
#   loop do
#     input = player[:strategy].call(player, game_state)
#     if input == :hit
#       deal_card!(player, game_state)
#       game_redraw(game_state)
#     end
#     break if input == :stay || end_turn?(player)
#   end
# end
#
# def players_in_play(game_state)
#   # migrated to `Game#players_by_highest_total` (consolidated)
# end
#
# def players_by_top_score(game_state)
#   # migrated to `Game#players_by_highest_total`
# end
#
# def winners(game_state)
#   # migrated to `Game#winners`
# end
#
# def winners_display(winners)
#   message = "No winner."
#   if winners.size > 1
#     winner_names = winners.map { |winner| winner[:name] }.join(' and ')
#     message = "Tie game between #{winner_names}."
#   elsif winners.size == 1 then message = "#{winners.first[:name]} won the game!"
#   end
#
#   puts "|*| #{message} |*|"
# end
#
# * Game Display *
#
# def game_table_lines(game_state)
#   game_state.dig(:table, :players).map do |participant|
#     # cards_display = # migrated to TwentyOneHand#to_s
#
#     "#{participant.name}:#{participant.hand}"
#   end
# end
#
# def game_redraw(game_state)
#   clear_console
#   messages_bordered_display(game_table_lines(game_state),
#                             StandardDeck::ICONS[:diamonds], header: ' Table ')
#   puts Common::Messages.empty_line
# end
#
# * Rounds (Scoring) *
# def set_state_create(players)
#   # Refactored to `GameSet` class
# end
#
# def update_set_score!(winners, set_state)
#   # Refactored to `GameSet` class
# end
#
# def set_state_by_score(set_state)
#   # Refactored to `GameSet` class
# end
#
# def set_score_display(set_state)
#   # Refactored to `GameSet`
# end
#
# def set_winner?(set_state)
#   # Refactored to `GameSet`
# end
#
# def set_winner_display(set_state)
#   # Refactored to `GameSet`
# end
#
# * Main *
#
# def play_round(players, set_state)
#   game_state = game_state_create(players)
#   deal_table!(game_state)
#   game_redraw(game_state)
#
#   participants.each do |player|
#     turn!(player, game_state)
#   end
#
#   game_redraw(game_state)
#   # migrated to `determine_winners`
# end
#
# def play_set(players)
#   # migrated to `Game#play_set` and `GameSet` (refactored)
# end
#
# def play_again?
#   # migrated to `Game#set#play_again?`
# end
#
# def play_loop(dealer_strategy, player_strategy)
#   # migrated to `Game#play_sets`
# end
#
# * Player Strategies *
#
# dealer_strategy = lambda do |dealer_player, _game_state|
#   # migrated to `ParticipantDealer#play`
# end
#
# def player_strategy_input_validator_create
#   # migrated to `ParticipantPlayer#prompt_play` (refactored)
# end
#
# def player_strategy_prompt(name, cards_value)
#   # migrated to `ParticipantPlayer#prompt_play`
# end
#
# player_strategy = lambda do |player, _game_state|
#   # migrated to `ParticipantPlayer#play`
# end
#
# # migrated to `main.rb`
#
