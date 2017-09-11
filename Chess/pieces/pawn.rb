require_relative 'piece'

class Pawn < Piece

  def to_s
    'P'.colorize(self.color)
  end

end
