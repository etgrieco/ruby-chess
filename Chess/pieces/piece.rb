class Piece
  attr_reader :color

  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
  end

  def to_s
    "p"
  end

  def inspect
    "p"
  end
end
