require_relative 'board'
require_relative 'player_human'
require_relative 'player_computer'
require_relative 'common'

class Game
  MARKS = %w[X O].freeze

  def play
    display_welcome
    initialize_board
    identify_players
    play_loop
    display_goodbye
  end

  private

  attr_accessor :board, :players, :winning_player

  def display_welcome
    puts "Welcome to Tic Tac Toe!#{Common::Messages.empty_line}"
  end

  def initialize_board
    size = Common::Prompt.until_valid(
      'What size board? (enter 3-9)',
      convert_input: ->(input) { input.to_i },
      validate: lambda do |converted_input|
                  unless converted_input.between?(3, 9)
                    raise ValidationError, 'Please enter a board size value between 3 and 9.'
                  end
                end
    )
    self.board = Board.new(size)
  end

  def identify_players
    self.players = []
    players.push(PlayerHuman.new(PlayerHuman.request_name, board))
    players.push(PlayerComputer.new(board))

    assign_marks
  end

  def assign_marks
    players.shuffle.each_with_index do |player, idx|
      player.initialize_mark(MARKS[idx])
    end
  end

  def play_loop
    loop do
      play_round

      puts(if winning_player.nil?
             'Draw'
           else
             winning_player.name
           end)

      break unless play_again?

      board.reset
    end
  end

  def play_round
    puts 'xoxoxox' while players_play_continue?
    draw_board
  end

  def draw_board(clear_console: true, display_selectors: false)
    Common.clear_console if clear_console
    board.draw(display_selectors: display_selectors)
  end

  def players_play_continue?
    players.each do |player|
      draw_board(display_selectors: true)
      player.mark_board
      self.winning_player = player if board.winner?
      return false if !winning_player.nil? || board.full?
    end

    true
  end

  def play_again?
    Common::Prompt.yes_or_no_is_yes?('Would you like to play again?')
  end

  def display_goodbye
    puts "#{Common::Messages.empty_line}Thank you for playing Tic Tac Toe! Goodbye :-)"
  end
end
