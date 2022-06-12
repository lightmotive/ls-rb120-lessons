require_relative 'common/common'
require_relative 'board'
require_relative 'players'
require_relative 'game_round_status'
require_relative 'game_set_status'
require_relative 'player_human'
require_relative 'player_computer'

class Game
  def play
    Common.clear_console
    display_welcome
    initialize_board
    initialize_players
    play_sets
    display_goodbye
  end

  private

  attr_accessor :board, :players, :round_status, :set_status

  def display_welcome
    Common::Messages.bordered_display('Welcome to Noughts and Crosses!', 'xo')
    puts Common::Messages.empty_line
  end

  def initialize_board
    self.board = Board.new
  end

  def initialize_players
    self.players = Players.new(board)
  end

  def play_sets
    self.set_status = GameSetStatus.new(players, 5)

    loop do
      play_set
      break unless play_again?
    end
  end

  def play_set
    set_status.reset

    loop do
      play_round
      set_status.round_winner(round_status.winner)
      break if set_status.end?(display_results: true)
      # Feature suggestion: track and then draw all round boards with outcomes in set.
    end
  end

  def play_round
    board.reset(board.size)
    players.assign_marks(shuffle: true)
    self.round_status = GameRoundStatus.new(board)
    players_move until round_status.end?
    round_completed
  end

  def draw_board(clear_console: true, with_keys: false)
    Common.clear_console if clear_console
    board.draw(with_keys: with_keys)
  end

  def round_completed
    Common.clear_console

    if round_status.win
      round_status.display_winner
    elsif round_status.draw
      round_status.display_draw
    end

    draw_board(clear_console: false)
  end

  def players_move
    players.each do |player|
      draw_board(with_keys: true) if player.human?
      player.mark_board
      round_status.check_move(player)
      break if round_status.end?
    end

    true
  end

  def play_again?
    puts Common::Messages.empty_line
    Common::Prompt.yes_or_no_is_yes?('Would you like to play again?')
  end

  def display_goodbye
    puts "#{Common::Messages.empty_line}Thank you for playing! Cheerio :-)"
  end
end
