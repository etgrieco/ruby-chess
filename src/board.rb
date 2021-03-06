require_relative 'pieces'
require_relative 'special_moves'

class Board
  include SpecialMoves

  attr_reader :grid

  def initialize(grid = nil)
    @grid = grid || new_game_grid
  end

  def move_piece(start_pos, end_pos)
    start_piece, end_piece = self[start_pos], self[end_pos]
    if special_move?(start_piece, end_piece) # performs move if available
    else
      if start_piece.class == NullPiece
        raise MoveError.new("There is no piece there")
      elsif start_piece.invalid_move?(end_pos) # excludes special moves
        raise MoveError.new("That's not a valid chess move")
      elsif start_piece.move_into_check?(end_pos) # excludes special moves
        raise MoveError.new("You can't place your own king into check")
      end
      move_piece!(start_pos, end_pos)
    end
  end

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    self[start_pos] = NullPiece.instance
    self[end_pos] = piece
    piece.change_position!(end_pos)
  end

  def self.in_bounds?(pos)
    pos.none? { |coord| coord < 0 || coord > 7 }
  end

  def checkmate?(player_color)
    in_check?(player_color) &&
      all_pieces(player_color).all? { |piece| piece.valid_moves.empty? }
  end

  def in_check?(player_color)
    king_pos = all_pieces(player_color).find(&:is_king?)&.position

    # castling exception: rook takes king out of board
    return false unless king_pos

    opponent_color = player_color == :black ? :white : :black
    other_pieces = all_pieces(opponent_color).reject(&:is_king?)

    other_pieces.any? { |piece| piece.moves.include?(king_pos) }
  end

  def is_empty?(pos)
    self[pos].is_a?(NullPiece)
  end

  def is_occupied?(pos)
    !is_empty?(pos)
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end

  def dup
    new_grid = Array.new(8) { Array.new }
    @grid.each.with_index do |row, row_idx|
      row.each do |piece|
        new_grid[row_idx] << piece.duplicate
      end
    end
    new_board = Board.new(new_grid)
    new_board.grid.flatten.each { |piece| piece.board = new_board }
    new_board
  end

  def piece_color(pos)
    self[pos].color
  end

  def all_pieces(color)
    @grid.flatten.select { |piece| piece.color == color }
  end

  private

  def populate_home_rows!(grid, color)
    row = color == :black ? 0 : 7
    pawn_row = color == :black ? 1 : 6

    grid[row] = [
      Rook.new([row, 0], color, self),
      Knight.new([row, 1], color, self),
      Bishop.new([row, 2], color, self),
      Queen.new([row, 3], color, self),
      King.new([row, 4], color, self),
      Bishop.new([row, 5], color, self),
      Knight.new([row, 6], color, self),
      Rook.new([row, 7], color, self)
    ]

    grid[pawn_row] = Array.new(8) { |i| Pawn.new([pawn_row, i], color, self) }
  end

  def new_game_grid
    new_grid = Array.new(8) { Array.new(8) }
    populate_home_rows!(new_grid, :black)
    populate_home_rows!(new_grid, :white)
    new_grid[2..5] = new_grid[2..5].map do
      Array.new(8) { NullPiece.instance }
    end
    new_grid
  end

end
