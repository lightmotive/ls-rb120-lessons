module RPS
  module Moves
    # TODO: enable players to select a skin.

    # Medieval skin:
    DATA = [MoveBase.new(:Rock, { name: 'Crystal',
                                  beats: { Scissors: { verb: 'relocates' },
                                           Lizard: { verb: 'relocates' } } }),
            MoveBase.new(:Paper, { name: 'Parchment',
                                   beats: { Rock: { verb: 'covers' },
                                            Spock: { verb: 'disproves' } } }),
            MoveBase.new(:Scissors, { name: 'Swords',
                                      beats: { Paper: { verb: 'cut' },
                                               Lizard: { verb: 'decapitate' } } }),
            MoveBase.new(:Spock, { name: 'Mage',
                                   beats: { Scissors: { verb: 'melts' },
                                            Rock: { verb: 'crushes' } } }),
            MoveBase.new(:Lizard, { name: 'Dragon',
                                    beats: { Paper: { verb: 'burns' },
                                             Spock: { verb: 'eats' } } })].freeze

    # Standard skin:
    # DATA = [MoveBase.new(:Rock, { beats: { Scissors: { verb: 'crushes' },
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
