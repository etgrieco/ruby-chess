class Piece
  attr_reader :color, :position
  attr_accessor :board

  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
  end

  def change_position(pos)
    @position = pos
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(end_pos)
    check_board = @board.dup
    check_board.move_piece(@position, end_pos)
    check_board.in_check?(@color)
  end

  def duplicate
    self.class.new(@position, @color, @board = nil)
  end

  def to_s
    "p"
  end

  def inspect
    "p"
  end
end
