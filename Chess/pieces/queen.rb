require_relative 'piece'

class Queen < Piece
  # include SlidingPiece

  def to_s
    'Q'.colorize(self.color)
  end

end
