require_relative 'piece'

class Rook < Piece
  include SlidingPiece

  def to_s
    'R'.colorize(self.color)
  end

  def move_dirs
    vertical_dirs
  end

end
