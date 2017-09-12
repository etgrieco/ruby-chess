require_relative 'piece'
require 'singleton'

class NullPiece < Piece
  include Singleton

  def initialize
  end

  def duplicate
    self.class.instance
  end

  def inspect
    "□"
  end
end
