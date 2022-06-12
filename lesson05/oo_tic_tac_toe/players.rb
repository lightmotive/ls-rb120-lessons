require_relative 'common/common'
require_relative 'player_human'
require_relative 'player_computer'

# Custom collection of `Player` objects.
class Players
  include Enumerable

  MARKS = %w[X O].freeze

  attr_reader :is_multiplayer

  def initialize(board)
    @is_multiplayer = prompt_multiplayer
    initialize_array_from_names(prompt_player_names, board)
  end

  def each(&block)
    array.each(&block)
  end

  def <=>(other)
    array <=> other
  end

  def shuffle!
    array.shuffle!
  end

  def assign_marks(shuffle: false)
    shuffle! if shuffle

    array.each_with_index do |player, idx|
      player.initialize_mark(MARKS[idx])
    end
  end

  private

  attr_reader :array

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

  def initialize_array_from_names(names, board)
    @array = names.map { |name| PlayerHuman.new(name, board) }
    array.push(PlayerComputer.new(board)) unless is_multiplayer
    array.shuffle!
  end
end
