require 'byebug'

module Castling

  def initialize(pos, color, board)
    super(pos, color, board)
    @has_moved = false
  end

  def has_moved?
    !!has_moved
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
    unless initial_castling_conditions_met?([self, piece])
      return false
    end

    row = self.position[0]
    king = self.is_king? ? self : piece
    rook = self.is_rook? ? self : piece

    position_difference = king.position[1] - rook.position[1]
    check_range = position_difference == 4 ? (1..3) : (5..6)

    positions = check_range.to_a.map { |col| [row, col] }

    if all_null?(positions) && none_in_check?(king, positions)
      return { Rook: king.position, King: rook.position } # truthy value to be used in castling_moves
    end
    false
  end

  private

  def initial_castling_conditions_met?(pieces)
    pieces.count(&:is_king?) == 1   &&
      pieces.count(&:is_rook?) == 1 &&
      pieces.none?(&:has_moved?)
  end

  def castling_moves
    other_klass = self.is_king? ? "Rook" : "King"
    teammates = board.all_pieces(self.color)
    castling_partners = teammates.select { |piece| piece.klass == other_klass }

    moves = []
    castling_partners.each do |piece|
      castle_move = can_castle?(piece)
      moves << castle_move[self.klass.to_sym] if castle_move
    end
    moves
  end

  def all_null?(positions)
    positions.all? { |pos| board[pos].klass == "NullPiece" }
  end

  def none_in_check?(piece, positions)
    positions.none? { |pos| piece.move_into_check?(pos) }
  end

  attr_accessor :has_moved

end
