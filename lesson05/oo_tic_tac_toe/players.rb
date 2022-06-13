require_relative 'common/common'
require_relative 'player_human'
require_relative 'player_computer'
require_relative 'board_markers'

# Custom collection of <`Player`-derived + `BoardMarker`-including> objects.
class Players
  include Enumerable
  include BoardMarkers

  attr_reader :is_multiplayer, :custom_marks_enabled

  alias players board_markers

  def initialize(board)
    @is_multiplayer = prompt_multiplayer
    initialize_players_from_names(prompt_player_names)
    assign_board_to_markers(board)
    @custom_marks_enabled = prompt_use_custom_marks
    custom_marks_enabled ? assign_custom_marks : assign_default_marks
  end

  def each(&block)
    players.each(&block)
  end

  def <=>(other)
    players <=> other
  end

  def shuffle!
    players.shuffle!

    assign_default_marks unless custom_marks_enabled

    nil
  end

  def to_ary
    players
  end

  private

  def prompt_multiplayer
    Common::Prompt.yes_or_no_is_yes?('Multiplayer?')
  end

  def prompt_player_names
    return [PlayerHuman.prompt_name] unless is_multiplayer

    prompt_multiplayer_names(2)
  end

  def prompt_multiplayer_names(count)
    count.times.each_with_object([]) do |idx, names|
      names << PlayerHuman.prompt_name("What's Player #{idx + 1}'s name?")
    end
  end

  def initialize_players_from_names(names)
    @board_markers = names.map { |name| PlayerHuman.new(name) }
    return if is_multiplayer

    @board_markers.push(PlayerComputer.new)
  end

  def prompt_use_custom_marks
    Common::Prompt.yes_or_no_is_yes?('Would you like to use custom marks?')
  end

  def assign_custom_marks
    players.select(&:human?).each do |player_human|
      player_human.assign_custom_mark(disallowed_marks: BoardMarkers::MARKS)
    end

    players.select(&:computer?).each do |marker|
      marker.assign_mark(BoardMarkers::MARKS[1])
    end
  end
end
