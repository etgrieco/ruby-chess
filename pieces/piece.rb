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
    :NullPiece => ' '
  }

  COLORS = {
    white: :light_white,
    black: :black
  }

  def initialize(position, color, board)
    @position, @color, @board = position, color, board
  end

  def change_position!(pos)
    @position = pos
  end


    def increment_pos(pos, diff)
      pos.map.with_index { |coord, idx| coord + diff[idx] }
    end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  # checks whether pos is included in a piece's valid moveset
  def invalid_move?(pos)
    !moves.include?(pos)
  end

  def valid_pos?(pos)
    Board.in_bounds?(pos) && board.piece_color(pos) != color
  end

  def move_into_check?(end_pos)
    check_board = @board.dup
    check_board.move_piece!(@position, end_pos)
    check_board.in_check?(@color)
  end

  def duplicate
    self.class.new(@position, @color, nil)
  end

  def to_s
    SYMBOLS[self.class.name.to_sym].colorize(COLORS[self.color])
  end

  def inspect
    "p"
  end
end
