require_relative 'board'
require_relative 'player_human'
require_relative 'player_computer'
require_relative 'common'

class Game
  MARKS = %w[X O].freeze

  def play
    display_welcome
    identify_players
    initialize_board
    play_loop
    display_goodbye
  end

  private

  attr_accessor :board_size, :board, :players, :winning_player

  def display_welcome
    puts "Welcome to Tic Tac Toe!#{Common.empty_line}"
  end

  def identify_players
    self.players = []
    players.push(PlayerHuman.new(PlayerHuman.request_name))
    players.push(PlayerComputer.new)

    assign_marks
  end

  def initialize_board
    print 'What size board? (enter 3-9) '

    self.board_size = loop do
      size = gets.strip.to_i
      break size if size.between?(3, 9)

      print 'Please enter a board size value between 3 and 9: '
    end
  end

  def create_board
    self.board = Board.new(board_size)
  end

  def assign_marks
    MARKS.shuffle.each_with_index do |mark, idx|
      players[idx].initialize_mark(mark)
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
    end
  end

  def play_round
    create_board
    puts 'xoxoxox' while players_play_continue?
  end

  def players_play_continue?
    players.each do |player|
      player.mark_board(board)
      self.winning_player = player if board.winner?
      return false if !winning_player.nil? || board.full?
    end

    board.draw

    true
  end

  def play_again?
    print 'Would you like to play again? (y/n) '
    Common.input_yes_or_no_is_yes?
  end

  def display_goodbye
    puts "#{Common.empty_line}Thank you for playing Tic Tac Toe! Goodbye :-)"
  end
end
