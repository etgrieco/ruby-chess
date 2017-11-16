require_relative 'piece'
require_relative '../piece_modules/sliding_piece'
require_relative '../board'

class Queen < Piece
  include SlidingPiece

  def inspect
    '♛'
  end

  def diffs
    DIAGONALS + LATERALS
  end

end
