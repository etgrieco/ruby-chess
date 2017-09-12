require_relative 'piece'
require_relative '../piece_modules/stepping_piece'
require_relative '../board'

class Knight < Piece
  include SteppingPiece

  def inspect
    '♞'
  end

  def to_s
    'K'.colorize(self.color)
  end

  def move_diffs
    [[-1, -2], [-1, 2], [1, -2], [1, 2],
      [-2, -1], [2, -1], [-2, 1], [2, 1]]
  end




end
