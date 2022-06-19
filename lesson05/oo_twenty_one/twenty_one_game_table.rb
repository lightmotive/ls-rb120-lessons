require_relative 'standard_deck'

class TwentyOneGameTable
  def initialize(participants)
    @participants = participants
  end

  def play
    participants.each(&:initialize_hand)
    self.deck = StandardDeck.new(auto_refill: true)
    deal_initial_cards
    draw
    turns
  end

  def winners
    winners = participants_by_highest_total
    return [] if winners.empty?

    winner_first = winners.first
    highest_total = winner_first.total

    [winner_first] + winners[1..].select do |winner|
      winner.total == highest_total
    end
  end

  def draw(clear_console: true)
    Common.clear_console if clear_console

    participant_lines = participants.map(&:game_display)

    Common::Messages.bordered_display(
      participant_lines, StandardDeck::ICONS[:diamonds], header: ' Table '
    )
    puts Common::Messages.empty_line
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

  private

  attr_accessor :deck
  attr_reader :participants

  def deal_initial_cards
    2.times do |card_idx|
      participants.each do |participant|
        deal(participant, face_up: card_idx.zero? || !participant.dealer?)
      end
    end
  end

  def turns
    participants.each { |participant| turn(participant) }
  end

  def turn(participant)
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
    card = deck.deal
    card.turn_up! if face_up
    participant.receive_card(card)
  end

  def participants_by_highest_total
    participants.reject(&:busted?).sort_by { |participant| -participant.total }
  end
end
