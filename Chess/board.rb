require_relative 'piece'
require_relative 'null'

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
    populate
  end

  def move_piece(start_pos, end_pos)
    piece = self[start_pos]
    raise StandardError.new("There is no piece there") if piece.class == NullPiece
    self[start_pos] = NullPiece
    self[end_pos] = piece

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
    @grid[0..1].each do |row|
      row.each_index do |idx|
        row[idx] = Piece.new
      end
    end

    @grid[2..5].each do |row|
      row.each_index do |idx|
        row[idx] = NullPiece.new
      end
    end

    @grid[6..7].each do |row|
      row.each_index do |idx|
        row[idx] = Piece.new
      end
    end
  end

end
