require_relative 'pieces'


class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
    populate
  end

  def move_piece(start_pos, end_pos)
    piece = self[start_pos]
    raise MoveError.new("There is no piece there") if piece.class == NullPiece
    self[start_pos] = NullPiece.new
    self[end_pos] = piece
  end

  def self.in_bounds?(pos)
    pos.none? {|coordinate| coordinate < 0 || coordinate > 7}
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row,col = pos
    @grid[row][col] = piece
  end

  private

  def populate
    @grid[0] = [
      Rook.new([0,0], :black, self),
      Knight.new([0,1], :black, self),
      Bishop.new([0,2], :black, self),
      Queen.new([0,3], :black, self),
      King.new([0,4], :black, self),
      Bishop.new([0,5], :black, self),
      Knight.new([0,6], :black, self),
      Rook.new([0,7], :black, self)
    ]

    @grid[1] = Array.new(8) { |i| Pawn.new([1,i], :black, self) }
    # @grid[1] = Array.new(8) { NullPiece.new } # remove pawns for testing

    @grid[2..5].each do |row|
      row.each_index do |idx|
        row[idx] = NullPiece.new()
      end
    end

    @grid[6] = Array.new(8) {|i| Pawn.new([6,i], :white, self)}

    @grid[7] = [
      Rook.new([7,0], :white, self),
      Knight.new([7,1], :white, self),
      Bishop.new([7,2], :white, self),
      Queen.new([7,3], :white, self),
      King.new([7,4], :white, self),
      Bishop.new([7,5], :white, self),
      Knight.new([7,6], :white, self),
      Rook.new([7,7], :white, self)
    ]
  end

end

class BoardErrors < StandardError

end

class MoveError < BoardErrors

end
