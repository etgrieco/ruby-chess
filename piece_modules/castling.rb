module Castling

  def initialize(pos, color, board)
    super(pos, color, board)
    @has_moved = false
  end

  def has_moved?
    status = !!has_moved
  end
  
  def change_position!(pos)
    super(pos)
    @has_moved = true
  end
  
  def moves
    base_moves = super
    base_moves + castling_moves
  end
  
  def can_castle?(piece)
    row = self.position[0]

    if initial_castling_conditions_met?(self, piece)
      king = klass == "King" ? self : piece
      rook = klass == "Rook" ? self : piece

      position_difference = king.position[1] - rook.position[1]
      check_range = position_difference == 4 ? (1..3) : (5..6)

      positions = check_range.to_a.map { |col| [row, col] }

      if all_null?(positions) && none_in_check?(king, positions)
        return { Rook: rook.position, King: king.position } # truthy value to be used in castling_moves
      end
    end
    false
  end

  private
  
  def initial_castling_conditions_met?(piece_1, piece_2)    
    (piece_1.klass == "King" && piece_2.klass == "Rook"    ||
      piece_1.klass == "Rook" && piece_2.klass == "King")  &&
      !piece_1.has_moved? && !piece_2.has_moved?
  end

  def all_null?(positions)
    positions.all? { |pos| board[pos].klass == "NullPiece" }
  end

  def none_in_check?(piece, positions)
    positions.none? { |pos| piece.move_into_check?(pos) }
  end
  
  def castling_moves
    other_klass = self.klass == "King" ? "Rook" : "King"
    other_pieces = board.all_pieces(self.color)
                    .select { |piece| piece.klass == other_klass }
    
    moves = []
    other_pieces.each do |piece|
      castle_move = can_castle?(piece)
      moves << castle_move[self.klass.to_sym] if castle_move
    end
    moves
  end

  attr_accessor :has_moved

end
