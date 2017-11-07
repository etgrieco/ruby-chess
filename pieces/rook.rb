require_relative 'piece'
require_relative '../piece_modules/sliding_piece'
require_relative '../board'

class Rook < Piece
  include SlidingPiece

  def inspect
    '♜'
  end

  def dirs
    LATERALS
  end

end
