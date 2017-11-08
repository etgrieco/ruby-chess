module Castling

  def initialize(pos, color, board)
    super(pos, color, board)
    @has_moved = false
  end

  def has_moved?
    status = !!has_moved
    @has_moved = true
  end

  private

  attr_accessor :has_moved

end
