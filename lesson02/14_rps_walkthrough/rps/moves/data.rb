module RPS
  module Moves
    # Specify `:name` in Hash object passed to `Move` to override symbol-based
    # name; `:name` is necessary only if symbol.to_s is not suitable for UX.
    DATA = [MoveBase.new(:Crystal, { beats: { Swords: { verb: 'relocates' },
                                              Dragon: { verb: 'relocates' } } }),
            MoveBase.new(:Parchment, { beats: { Crystal: { verb: 'covers' },
                                                Mage: { verb: 'disproves' } } }),
            MoveBase.new(:Swords, { beats: { Parchment: { verb: 'cut' },
                                             Dragon: { verb: 'decapitate' } } }),
            MoveBase.new(:Mage, { beats: { Swords: { verb: 'melts' },
                                           Crystal: { verb: 'crushes' } } }),
            MoveBase.new(:Dragon, { beats: { Parchment: { verb: 'burns' },
                                             Mage: { verb: 'eats' } } })].freeze

    # Standard moves:
    # MOVES_DATA = [MoveBase.new(:Rock, { beats: { Scissors: { verb: 'crushes' },
    #                                             Lizard: { verb: 'crushes' } } }),
    #              MoveBase.new(:Paper, { beats: { Rock: { verb: 'covers' },
    #                                              Spock: { verb: 'disproves' } } }),
    #              MoveBase.new(:Scissors, { beats: { Paper: { verb: 'cut' },
    #                                                 Lizard: { verb: 'decapitate' } } }),
    #              MoveBase.new(:Spock, { beats: { Scissors: { verb: 'smashes' },
    #                                              Rock: { verb: 'vaporizes' } } }),
    #              MoveBase.new(:Lizard, { beats: { Paper: { verb: 'eats' },
    #                                               Spock: { verb: 'poisons' } } })].freeze
  end
end
