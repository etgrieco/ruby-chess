require_relative 'piece'
require_relative '../piece_modules/sliding_piece'
require_relative '../board'

class Rook < Piece
  include SlidingPiece

  def to_s
    'R'.colorize(self.color)
  end

  def move_dirs
    vertical_dirs
  end

end
