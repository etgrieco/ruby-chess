# Ruby Chess

A chess game with a command-line interface. Includes player-versus-player and player-versus-ai options.

## Instructions

Clone the repository and run the game using the command `ruby game.rb` from the root directory. Built using Ruby version 2.3+. Use the [Bundler gem](https://github.com/bundler/bundler-site) to run with the appropriate Ruby version and external gem dependencies.

The game follows the typical rules of chess, and plays until either player places the other in checkmate. Use the arrow-keys (or WASD) to move the cursor, and space/enter to select a piece. Following the touch-move rule of chess, once a piece is selected, you must perform a legal move with that piece!

## Features

### Command-line Unicode 'graphical' interface

While the entire program runs in the command line, the program was built with [Unicode chess symbols](https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode). The [colorize](https://github.com/fazibear/colorize) Ruby gem is used to color the pieces and board for an easy user-interface. It is recommended that you zoom into your terminal interface if playing the game on a higher resolution (1080p+) monitor.

The interface includes error-messages for invalid moves, including moves that place your king into check/checkmate!

### Todos
`Special Moves`
* En Passant Pawn Capture
* Castling
* Promotion

`Advanced Win/Loss Conditions`
* Stalemate