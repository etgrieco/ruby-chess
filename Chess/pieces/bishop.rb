require_relative 'piece'
require_relative '../piece_modules/sliding_piece'
require_relative '../board'

class Bishop < Piece
  include SlidingPiece

  def to_s
    'B'.colorize(self.color)
  end

  def move_dirs
    [[-1, -1], [1, 1], [-1, 1], [1, -1]]
  end

end
