require_relative 'piece'
require_relative '../piece_modules/sliding_piece'
require_relative '../board'

class Queen < Piece
  include SlidingPiece

  def to_s
    'Q'.colorize(self.color)
  end

  def move_dirs
    diagnal_dirs + vertical_dirs
  end

end
