# Object-oriented Twenty One Game

## Description

Twenty-One is a card game consisting of a dealer and a player, where the participants try to get as close to 21 as possible without going over.

Here is an overview of the game:
- Both participants are initially dealt 2 cards from a 52-card deck.
- The player takes the first turn, and can "hit" or "stay".
- If the player busts, he loses. If he stays, it's the dealer's turn.
- The dealer must hit until his cards add up to at least 17.
- If he busts, the player wins. If both player and dealer stays, then the highest total wins.
- If both totals are equal, then it's a tie, and nobody wins.

### Nouns and verbs

**Nouns with associated verbs**
- class `StandardDeckCard`
  - has suit
  - has rank
  - has `face_up?`
  - has display value (`to_s`)
    - different display depending on `face_up?`
- class `StandardDeck`
  - has `array` (array of `StandardDeckCard` instances)
  - `initialize`
    - invoke `create`
  - `create`
    - generate standard 52-card deck and shuffle
  - `pull_top_card`
    - remove and return first card from `deck`
- class `StandardDeckHand`
  - has `array` (of `StandardDeckCard` instances)
  - has `receive(card)`
  - `to_s`
    - return string that displays cards
- class `TwentyOneHand < StandardDeckHand`
  - has `WINNING_SCORE = 21`
  - has `total`
  - `busted?`
    - return `total > WINNING_SCORE`
  - `won?`
    - return `total == WINNING_SCORE`
  - override `receive(card)` method
    - `super`
    - `calculate_total()`
  - `calculate_total`
    - Calculate and set `total` attr
  - override `to_s`
    - "#{super} + #{total}"
- class `Participant`
  - has `is_dealer`
  - specify `is_dealer` on init
  - has `hand` (`TwentyOneHand` instance)
  - `receive_card(card)`
    - forward to `hand.receive_card`
  - `play` (abstract - implement in subclasses) => `hit` or `stay`
  - `busted?`
    - return `hand.busted?`
  - `won?`
    - return `hand.won?`
  - *Subclasses:*
    - class `Dealer`
      - has `MINIMUM_TOTAL = 17`
      - `play`
        - Must `hit` while `total < MINIMUM_TOTAL`
        - Can `stay` if `total >= MINIMUM_TOTAL`
    - class `Player`
      - `play`
        - human player chooses after each card is received unless `busted?`
- class `Game`
  - has `participants`, including at least 1 dealer and 1 player
    - add `Dealer` instance after adding `Player` instance(s)
  - has `card_table` (`CardTable` instance)
    - initialize with `participants`
  - has `deck` (`StandardDeck` instance)
  - `deal_initial_hands` to all `participants`
    - different behavior for dealer vs player
  - `players_play`
    - iterate through `participants` who `play` until bust, win, or stay
      - `hit(player)` if `player.play == hit`
    - dealer plays last
  - `hit(param: player instance)`
    - deal 1 card to player
  - `draw_table`
    - iterate through `participants` to displays cards and values
      - display card face-up or down
      - display value only if all cards are face-up

### CRC Cards

Skipping this step due to simplified game and extended structure above.