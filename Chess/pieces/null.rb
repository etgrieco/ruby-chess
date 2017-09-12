require_relative 'piece'
require 'singleton'

class NullPiece < Piece
  include Singleton

  def initialize
  end

  def duplicate
    self.class.instance
  end

  def to_s
    "□"
  end

  def inspect
    "n"
  end
end
