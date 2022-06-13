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

**Nouns**
- participant
  - hand ([*cards])
  - Subclasses:
    - dealer
    - player
- deck
  - card
- turn
- total
- busted?(participant.hand)
- winning score

**Verbs**
- deal card
- deal initial hand
- hit
- stay
- show winner

### CRC Cards

Formalize objects and associate verbs with nouns.

- [View CRC Cards - interactive](https://echeung.me/crcmaker/)
- [View CRC Cards](crc_cards.pdf)