require_relative 'piece'

class Rook < Piece
  # include SlidingPiece

  def to_s
    'R'.colorize(self.color)
  end

end
