require_relative 'piece'
require_relative '../piece_modules/stepping_piece'
require_relative '../board'

class King < Piece
  include SteppingPiece

  def inspect
    '♚'
  end

  def to_s
    '♔'.colorize(self.color)
  end

  def move_diffs
    [[-1, -1], [-1, 0], [-1, 1], [0, -1],
    [0, 1], [1, -1], [1, 0], [1, 1]]
  end

end
