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

  private

  attr_accessor :has_moved

end
