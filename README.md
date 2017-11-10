# Ruby Chess

A chess game with a command-line interface.

## Instructions

Requirements: Ruby version 2.3+.

Clone/download the repository. Navigate to the repository's directory. Ensure the `colorize` gem is installed using [bundler](https://bundler.io/) (`bundle install`). Run the game with `ruby game.rb`.

The game follows the typical rules of chess, and plays until either player places the other in checkmate. Use the arrow-keys (or WASD) to move the cursor, and space/enter to select a piece. Following the touch-move rule of chess, once a piece is selected, you must perform a legal move with that piece!

## Features

### Command-line Unicode 'graphical' interface

While the entire program runs in the command line, the program was built with [Unicode chess symbols](https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode). The [colorize](https://github.com/fazibear/colorize) Ruby gem is used to color the pieces and board for an easy user-interface. It is recommended that you zoom into your terminal interface if playing the game on a higher resolution (1080p+) monitor.

The interface includes error-messages for invalid moves, including moves that place your king into check/checkmate!

![demo](https://github.com/etgrieco/ruby-chess/blob/master/docs/demo.gif?raw=true)

### Todos
`Special Moves`
- [x] Castling

![castling demo](https://github.com/etgrieco/ruby-chess/blob/master/docs/castling-demo.gif?raw=true)

- [ ] En Passant Pawn Capture
- [ ] Pawn Promotion

`Advanced Win/Loss Conditions`
- [ ] Stalemate
