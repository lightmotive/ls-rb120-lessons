require_relative 'rps/common'
require_relative 'rps/game'

game = RPS::Game.new(winning_score: 3)
game.play
