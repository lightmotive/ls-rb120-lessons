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
- class `Participant`
  - has `is_dealer`
  - specify `is_dealer` on init
  - `hand` (attr: array of `StandardDeckCard` instances)
  - `total`
    - `calculate_total` after each play and save in this attr (better performance)
  - `receive_card(Card instance)`
  - `play` (abstract - implement in subclasses) => `hit` or `stay`
  - `hand_busted?(param: player.hand instance)`
    - return whether hand total > `WINNING_SCORE`
  - `hand_won?(param: player.hand instance)`
    - return whether hand total == `WINNING_SCORE`
  - *Subclasses:*
    - class `Dealer`
      - `play`
        - Must `hit` until total is at least 17
        - Can `stay` when hand total >= 17
    - class `Player`
      - `play`
        - human player chooses after each card is dealt
- class `Game`
  - has `WINNING_SCORE`
  - has `participants`, including at least 1 dealer and 1 player
    - add `Dealer` instance after adding `Player` instance(s)
  - has `card_table` (`CardTable` instance)
    - initialize with `participants`
  - has `deck` (`StandardDeck` instance)
  - `deal_initial_hands` to `participants`
    - different behavior for dealer vs player
  - `players_play`
    - iterate through `participants` who play until bust, win, or stay
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