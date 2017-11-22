# Ruby Chess

A chess game with a command-line interface.

## Instructions

Requirements: Ruby version 2.3+.

Clone/download the repository. Navigate to the repository's directory. Ensure the `colorize` gem is installed using [bundler](https://bundler.io/) (`bundle install`). Run the game with `ruby chess.rb`.

The game follows the typical rules of chess, and plays until either player places the other in checkmate. Use the arrow-keys (or WASD) to move the cursor, and space/enter to select a piece. Following the touch-move rule of chess, once a piece is selected, you must perform a legal move with that piece!

It is recommended that you zoom into your terminal interface (`COMMAND + "+"`) if playing the game on a higher resolution (1080p+) monitor.

## Highlights

### DRY Chess Code

The project utilizes DRY, readable, and succinct code-base for a game that has a quite complex move set. Creative use of modules were employed to keep the number of piece-specific methods down to a bare-minimum. Pieces were divided into "stepping" and "sliding" categories, and modules were written to modify behaviors based on these properties. As a result, complex pieces such as Knight and Queen, can be implemented quite simply without repetitive code.

Stepping Pieces:

```Ruby
module SteppingPiece

  def moves
    moves = diffs.map { |diff| increment_pos(position, diff) }
    moves = Set.new(moves)
    moves.keep_if { |move| valid_pos?(move) }
  end

end

class Knight < Piece
  include SteppingPiece

  def diffs
    [[-1, -2], [-1, 2], [1, -2], [1, 2],
     [-2, -1], [2, -1], [-2, 1], [2, 1]]
  end

end
```

Sliding Piece:
```Ruby
module SlidingPiece

  DIAGONALS = [[-1, -1], [1, 1], [-1, 1], [1, -1]].freeze
  LATERALS = [[-1, 0], [1, 0], [0, 1], [0, -1]].freeze

  def moves
    moves = Set.new
    diffs.each do |diff|
      pos = increment_pos(position, diff)
      while valid_pos?(pos)
        moves << pos
        break if board.is_occupied?(pos)
        pos = increment_pos(pos, diff)
      end
    end
    moves
  end
end

class Queen < Piece
  include SlidingPiece

  def diffs
    DIAGONALS + LATERALS
  end

end

```

This coding approach also takes advantage of Ruby's introspection features to keep the overall codebase as readable as possible. For example, an `is_{PIECE}` method missing method was built to easily look for specific pieces, especially when implementing special moves such as castling:

```Ruby
class Piece
#...
  SYMBOLS = {
    King:   '♚', Queen:  '♛', Rook: '♜',
    Bishop: '♝', Knight: '♞', Pawn: '♟', NullPiece: ' '
  }.freeze

   def klass
    self.class.to_s
  end

  def method_missing(m, *args, &block)
    # e.g. is_king?
    piece_key = m.to_s.split("is_")[1][0...-1].capitalize
    if SYMBOLS.keys.map(&:to_s).include?(piece_key)
      return self.klass == piece_key
    else
      super
    end
  end
end
```

### Command-line Unicode 'graphical' interface

While the entire program runs in the command line, the program was built with [Unicode chess symbols](https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode). The [colorize](https://github.com/fazibear/colorize) Ruby gem is used to color the pieces and board for an easy user-interface.

The interface includes moves-highlighting for a piece's available moves.

![demo](https://github.com/etgrieco/ruby-chess/blob/master/docs/demo.gif?raw=true)

### Todos
`AI`
- [ ] Simple player AI that can handle check scenarios

`Special Moves`
- [x] Castling

![castling demo](https://github.com/etgrieco/ruby-chess/blob/master/docs/castling-demo.gif?raw=true)

- [ ] En Passant Pawn Capture
- [ ] Pawn Promotion

`Advanced Win/Loss Conditions`
- [ ] Stalemate
