require_relative 'abstract_not_implemented_error'

# Tradeoff discussion regarding loosely coupling `Board` and `Player` classes:
# Ideally, we want to minimize coupling between classes. `Player` needs to be
# aware of a specific `Board` instance, while `Board` doesn't need to be aware
# of a specific `Player` instance. Therefore, there is a loose coupling between
# the two classes, but it's an acceptable tradeoff in this program.
#
# Pros:
# - Player move strategy is encapsulated in one place, minimizing complexity.
# - No circular dependencies between `Board` and `Player`.
#
# Cons:
# - `Player` needs access to a specific `Board` instance that `Game` cannot
#   replace, thus requiring slightly more complicated Game + players
#   instantiation.
#
# The `Player` subclass must be aware of the `Game`'s `Board` instance to
# execute a specific strategy. Significant move strategy logic is currently
# implemented in the `PlayerComputer` class only, but similar logic could apply
# to a future "Suggestions" feature that gives the user hints about how to move.
#
# Therefore, it makes sense to put player strategy logic directly in `Player`
# subclasses in order to avoid an overly complex design (in this case)
# that would require several additional classes, e.g.:
# - `PlayerStrategy` superclass and player-specific subclasses.
#   - That class would still need to be aware of `Board`.
# - `Player` returns `PlayerStrategy` subclass type or instance.
# - `MoveOrchestrator` class that centralizes board awareness and marking.
class Player
  attr_reader :name, :is_computer, :board, :mark

  def initialize(name, is_computer, board)
    @name = name
    @is_computer = is_computer
    @board = board
  end

  # Abstract: concrete should invoke `board[key] = self` (assign player to space).
  def mark_board
    raise AbstractNotImplementedError
  end

  def human?
    !is_computer
  end

  def computer?
    is_computer
  end

  def initialize_mark(mark)
    @mark = mark
  end

  def to_s
    "#{name} (#{mark})"
  end

  protected

  # Get space keys that would complete a line for this player.
  def keys_to_win
    keys_to_win_in_lines(board.all_lines)
  end

  # Get space keys that would complete a line for anyone other than this player.
  def keys_to_defend
    keys_to_defend_in_lines(board.all_lines)
  end

  def keys_to_win_in_lines(lines)
    completion_sets_for_self = lines.select do |line|
      line.count { |space| space.player == self } == board.size - 1
    end

    board.empty_keys_in_sets(completion_sets_for_self)
  end

  def keys_to_defend_in_lines(lines)
    completion_sets_against_self = lines.select do |line|
      line.count { |space| !space.unmarked? && space.player != self } == board.size - 1
    end

    board.empty_keys_in_sets(completion_sets_against_self)
  end
end
