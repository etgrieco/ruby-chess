require_relative 'piece'
require_relative '../piece_modules/stepping_piece'
require_relative '../board'

class King < Piece
  include SteppingPiece
  

  def initialize(pos, color, board)
    super(pos, color, board)
    @has_moved = false
  end

  def has_moved?
    !!has_moved
  end
  
  def inspect
    '♚'
  end

  def diffs
    [[-1, -1], [-1, 0], [-1, 1], [0, -1],
    [0, 1], [1, -1], [1, 0], [1, 1]]
  end

  private
  
  def make_move
    @has_moved = true
  end
  
  attr_accessor :has_moved
end
