require_relative 'piece'
require_relative '../piece_modules/sliding_piece'
require_relative '../board'

class Bishop < Piece
  include SlidingPiece

  def inspect
    '♝'
  end

  def move_dirs
    diagnal_dirs
  end

end
