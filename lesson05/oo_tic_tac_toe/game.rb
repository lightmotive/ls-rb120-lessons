require_relative 'common/common'
require_relative 'board'
require_relative 'players'
require_relative 'game_round'
require_relative 'game_set'
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

  attr_accessor :board, :players, :round, :set

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
    self.set = GameSet.new(players, win_score: 5)

    loop do
      play_set
      break unless set.play_again?
    end
  end

  def play_set
    set.reset

    loop do
      play_round
      set.round_winner(round.winner)
      break if set.end?(display_results: true)
      # Feature suggestion: track and then draw all round boards with outcomes in set.
    end
  end

  def play_round
    board.reset(board.size)
    players.shuffle!
    self.round = GameRound.new(board)
    players_move until round.end?
    round_completed
  end

  def draw_board(clear_console: true, with_keys: false)
    Common.clear_console if clear_console
    board.draw(with_keys: with_keys)
  end

  def round_completed
    Common.clear_console

    if round.win
      round.display_winner
    elsif round.draw
      round.display_draw
    end

    draw_board(clear_console: false)
  end

  def players_move
    players.each do |player|
      draw_board(with_keys: true) if player.human?
      player.mark_board
      round.check_move(player)
      break if round.end?
    end

    true
  end

  def display_goodbye
    puts "#{Common::Messages.empty_line}Thank you for playing! Cheerio :-)"
  end
end
