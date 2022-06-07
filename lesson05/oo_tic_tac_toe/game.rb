require_relative 'common/common'
require_relative 'board'
require_relative 'game_round_status'
require_relative 'player_human'
require_relative 'player_computer'

class Game
  MARKS = %w[X O].freeze

  def play
    Common.clear_console
    display_welcome
    identify_players
    play_set
    display_goodbye
  end

  private

  attr_accessor :board, :players, :round_status

  def display_welcome
    puts "Welcome to Tic Tac Toe!#{Common::Messages.empty_line}"
  end

  def identify_players
    self.board = Board.new
    self.players = []
    players.push(PlayerHuman.new(PlayerHuman.request_name, board))
    players.push(PlayerComputer.new(board))
  end

  def assign_marks
    players.shuffle!
    players.each_with_index do |player, idx|
      player.initialize_mark(MARKS[idx])
    end
  end

  def play_again?
    puts Common::Messages.empty_line
    Common::Prompt.yes_or_no_is_yes?('Would you like to play again?')
  end

  def play_set
    loop do
      play_round
      break unless play_again?
    end
  end

  def play_round
    board.reset
    assign_marks
    self.round_status = GameRoundStatus.new(board)
    players_move until round_status.end?
    round_completed
  end

  def draw_board(clear_console: true, display_selectors: false)
    Common.clear_console if clear_console
    board.draw(display_selectors: display_selectors)
  end

  def round_completed
    Common.clear_console

    if round_status.win
      # display_win(players, game_state)
    elsif round_status.draw
      Common::Messages.bordered_display('Round draw!', '-')
    end

    draw_board(clear_console: false)
  end

  def players_move
    players.each do |player|
      draw_board(display_selectors: true)
      player.mark_board
      round_status.check_move(player)
      break if round_status.end?
    end

    true
  end

  def display_goodbye
    puts "#{Common::Messages.empty_line}Thank you for playing Tic Tac Toe! Goodbye :-)"
  end
end
