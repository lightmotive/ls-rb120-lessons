require_relative 'standard_deck'
require_relative 'participant_dealer'
require_relative 'participant_player'

class Game
  attr_reader :deck, :participants

  def initialize
    # Initialize deck and participants
    # Deal initial cards
    # ...
  end

  private

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
end

# Procedural code to be migrated to OOP:
# **************************************

# frozen_string_literal: true

# require_relative '../../ruby-common/prompt'
# require_relative '../../ruby-common/validation_error'
# require_relative '../../ruby-common/messages'
#
#
# INPUTS = { hit: 'h', stay: 's' }.freeze
# DEALER_NAME = 'Dealer'
# MAX_VALUE = 21
# DEALER_HITS_UNTIL_DEFAULT_VALUE = 17
# SCORE_TO_WIN_ROUND = 5 # We could allow player(s) to specify that score.
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
#   cards.all? { |card| card[:face_up] }
# end
#
# def cards_value(cards)
#   return nil unless all_cards_face_up?(cards)
#
#   value_with_ace11 = cards.sum { |card| card_value(card, ace_value: 11) }
#   return value_with_ace11 if value_with_ace11 <= MAX_VALUE
#
#   cards.sum { |card| card_value(card, ace_value: 1) }
# end
#
# def cards_for_display(cards)
#   cards.map do |card|
#     card[:face_up] ? "#{card[:suit]}#{card[:value]}" : FACE_DOWN_ICON
#   end
# end
#
# * Game State *
#
# def table_create(players)
#   { players: players.map { |player| player.merge({ cards: [] }) } }
# end
#
# def game_state_create(players)
#   {
#     deck: cards_create.shuffle.shuffle.shuffle,
#     table: table_create(players)
#   }
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
#   players_dealer_last = players_dealer_last(game_state)
#   2.times do |card_idx|
#     players_dealer_last.each do |player|
#       face_up = (!player[:is_dealer]) || card_idx == 0
#       deal_card!(player, game_state, face_up: face_up)
#     end
#   end
# end
#
# * Players *
#
# def welcome_display
#   clear_console
#
#   message = "#{StandardDeck::ICONS[:clubs]} Welcome to Twenty-One! #{StandardDeck::ICONS[:clubs]}"
#   border = "#{StandardDeck::ICONS[:spades]}#{StandardDeck::ICONS[:hearts].center(
#     message.length - 2, StandardDeck::ICONS[:diamonds]
#   )}#{StandardDeck::ICONS[:spades]}"
#
#   puts border
#   puts message
#   puts border
#   display_empty_line
# end
#
# def players_prompt(player_strategy)
#   welcome_display
#
#   players = []
#   # Extra Feature: Prompt for player count (up to 3) and names for each.
#   # - Ensure unique names!
#   puts "What's your name?"
#   players.push({ name: gets.strip, is_dealer: false,
#                  strategy: player_strategy })
# end
#
# def players_append_dealer!(players, dealer_strategy)
#   players.push({ name: DEALER_NAME, is_dealer: true,
#                  strategy: dealer_strategy })
# end
#
# def busted?(cards_value)
#   return false if cards_value.nil?
#
#   cards_value > MAX_VALUE
# end
#
# def end_turn?(player)
#   value = player[:cards_value]
#   return false if value.nil?
#
#   busted?(value) || value == MAX_VALUE
# end
#
# def players_dealer_last(game_state)
#   players = game_state.dig(:table, :players)
#   players.sort_by { |player| player[:is_dealer] ? 1 : 0 }
# end
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
#   game_state.dig(:table, :players).reject do |player|
#     busted?(player[:cards_value])
#   end
# end
#
# def players_by_top_score(game_state)
#   players_in_play(game_state).sort_by { |player| -player[:cards_value] }
# end
#
# def winners(game_state)
#   players = players_by_top_score(game_state)
#   return [] if players.empty?
#
#   winner = players.first
#   winning_score = winner[:cards_value]
#
#   [winner] + players[1..-1].select do |player|
#     player[:cards_value] == winning_score
#   end
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
#   game_state.dig(:table, :players).map do |player|
#     cards = player[:cards]
#     value = player[:cards_value]
#     busted_display = " - Busted!" if busted?(value)
#     value_display = " [#{value}#{busted_display}]" unless value.nil?
#     cards_display = cards_for_display(cards).join(' | ')
#
#     "#{player[:name]}:#{value_display} #{cards_display}"
#   end
# end
#
# def game_redraw(game_state)
#   clear_console
#   messages_bordered_display(game_table_lines(game_state),
#                             StandardDeck::ICONS[:diamonds], header: ' Table ')
#   display_empty_line
# end
#
# * Rounds (Scoring) *
# def round_state_create(players)
#   players.each_with_object({}) { |player, scores| scores[player[:name]] = 0 }
# end
#
# def update_round_score!(winners, round_state)
#   return if winners.nil? || winners.count != 1
#
#   round_state[winners.first[:name]] += 1
# end
#
# def round_state_by_score(round_state)
#   round_state.sort_by { |_, score| -score }
# end
#
# def round_score_display(round_state)
#   display_empty_line
#   messages_bordered_display(
#     round_state_by_score(round_state).map do |(name, score)|
#       "#{name}: #{score}"
#     end,
#     StandardDeck::ICONS[:diamonds], header: ' Scoreboard '
#   )
# end
#
# def round_winner?(round_state)
#   round_state_by_score(round_state).first[1] == SCORE_TO_WIN_ROUND
# end
#
# def round_winner_display(round_state)
#   display_empty_line
#   puts "|**| #{round_state_by_score(round_state).first[0]} won the round! |**|"
# end
#
# * Main *
#
# def play_game(players, round_state)
#   game_state = game_state_create(players)
#   deal_table!(game_state)
#   game_redraw(game_state)
#
#   players_dealer_last(game_state).each do |player|
#     turn!(player, game_state)
#   end
#
#   game_redraw(game_state)
#   winners = winners(game_state)
#   update_round_score!(winners, round_state)
#   winners_display(winners)
# end
#
# def play_round(players)
#   round_state = round_state_create(players)
#   loop do
#     play_game(players, round_state)
#
#     round_score_display(round_state)
#     break round_winner_display(round_state) if round_winner?(round_state)
#
#     display_empty_line
#     prompt_enter_to_continue("Press enter to continue round...")
#   end
# end
#
# def play_again?
#   display_empty_line
#   prompt_yes_or_no("Would you like to another round?") == 'y'
# end
#
# def play_loop(dealer_strategy, player_strategy)
#   players = players_prompt(player_strategy)
#   players_append_dealer!(players, dealer_strategy)
#
#   loop do
#     play_round(players)
#
#     break puts 'Thank you for playing Twenty-One!' unless play_again?
#   end
# end
#
# * Player Strategies *
#
# dealer_strategy = lambda do |dealer_player, _game_state|
#   value = dealer_player[:cards_value]
#   return :hit if value < DEALER_HITS_UNTIL_DEFAULT_VALUE
#
#   :stay
# end
#
# def player_strategy_input_validator_create
#   lambda do |input|
#     unless INPUTS.values.include?(input)
#       raise ValidationError,
#             "Please enter either #{INPUTS.values.join(' or ')}."
#     end
#   end
# end
#
# def player_strategy_prompt(name, cards_value)
#   inputs_display = INPUTS.map do |key, value|
#     "#{key.to_s.capitalize} (#{value})"
#   end.join(' or ')
#
#   prompt_until_valid(
#     "#{name}, you have #{cards_value}. #{inputs_display}?",
#     convert_input: ->(input) { input.downcase },
#     validate: player_strategy_input_validator_create
#   )
# end
#
# player_strategy = lambda do |player, _game_state|
#   cards_value = player[:cards_value]
#   player_input = player_strategy_prompt(player[:name], cards_value)
#   return INPUTS.rassoc(player_input)[0]
# end
#
# * Play with specific strategies (easily customize strategies) *
#
# play_loop(dealer_strategy, player_strategy)
#
