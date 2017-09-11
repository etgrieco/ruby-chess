require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display

  attr_accessor :current_pos

  def initialize(board)
    @board = board
    @current_pos = [0, 0]
  end

  def get_input
    cursor = Cursor.new(@current_pos, @board)
    until cursor.selected
      render
      @current_pos = cursor.get_input
      system 'clear'
    end
    @current_pos
  end

  def render
    @board.grid.each.with_index do |row, row_idx|
      row.each.with_index do |piece, col_idx|
        if [row_idx, col_idx] == @current_pos
          print piece.to_s.colorize(:red)
        else
          print piece
        end
        print " "
      end
      puts ""
    end
  end


end

a = Board.new
b = Display.new(a)
pos = b.get_input
