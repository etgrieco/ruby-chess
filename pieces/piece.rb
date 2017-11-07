class Piece
  attr_reader :color, :position
  attr_accessor :board

  SYMBOLS = {
    :King => '♚',
    :Queen => '♛',
    :Rook => '♜',
    :Bishop => '♝',
    :Knight => '♞',
    :Pawn => '♟',
    :NullPiece => '□'
  }

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
    check_board.move_piece!(@position, end_pos)
    check_board.in_check?(@color)
  end

  def duplicate
    self.class.new(@position, @color, nil)
  end

  def is_empty?(pos)
    self[pos].is_a?(NullPiece)
  end

  def is_occupied?(pos)
    !is_empty(pos)
  end

  def to_s
    SYMBOLS[self.class.name.to_sym].colorize(self.color)
  end

  def inspect
    "p"
  end
end
