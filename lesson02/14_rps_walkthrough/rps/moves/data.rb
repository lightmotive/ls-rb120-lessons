module RPS
  module Moves
    # TODO: enable players to select a skin.

    # Medieval skin:
    DATA = [Base.new(:Rock, { name: 'Crystal',
                              beats: { Scissors: { verb: 'relocates' },
                                       Lizard: { verb: 'relocates' } } }),
            Base.new(:Paper, { name: 'Parchment',
                               beats: { Rock: { verb: 'covers' },
                                        Spock: { verb: 'disproves' } } }),
            Base.new(:Scissors, { name: 'Swords',
                                  beats: { Paper: { verb: 'cut' },
                                           Lizard: { verb: 'decapitate' } } }),
            Base.new(:Spock, { name: 'Mage',
                               beats: { Scissors: { verb: 'melts' },
                                        Rock: { verb: 'crushes' } } }),
            Base.new(:Lizard, { name: 'Dragon',
                                beats: { Paper: { verb: 'burns' },
                                         Spock: { verb: 'eats' } } })].freeze

    # Standard skin:
    # DATA = [Base.new(:Rock, { beats: { Scissors: { verb: 'crushes' },
    #                                             Lizard: { verb: 'crushes' } } }),
    #              Base.new(:Paper, { beats: { Rock: { verb: 'covers' },
    #                                              Spock: { verb: 'disproves' } } }),
    #              Base.new(:Scissors, { beats: { Paper: { verb: 'cut' },
    #                                                 Lizard: { verb: 'decapitate' } } }),
    #              Base.new(:Spock, { beats: { Scissors: { verb: 'smashes' },
    #                                              Rock: { verb: 'vaporizes' } } }),
    #              Base.new(:Lizard, { beats: { Paper: { verb: 'eats' },
    #                                               Spock: { verb: 'poisons' } } })].freeze
  end
end
