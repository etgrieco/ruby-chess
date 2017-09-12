require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display

  attr_accessor :current_pos

  def initialize(board, current_pos = [4,4], selected_pos = nil)
    @board = board
    @current_pos = current_pos
    @selected_pos = selected_pos
  end

  def get_input
    cursor = Cursor.new(@current_pos, @board)
    until cursor.selected?
      render
      @current_pos = cursor.get_input
      system 'clear'
    end
    @current_pos
  end

  def render
    count = 0

    @board.grid.each.with_index do |row, row_idx|
      print " "
      row.each.with_index do |piece, col_idx|
        if [row_idx, col_idx] == @current_pos
          print piece.to_s.colorize(:red)
        elsif [row_idx, col_idx]  == @selected_pos
          print piece.to_s.colorize(:blue)
        else
          print piece
        end
        print " "
      end
      puts ""
    end
  end


end
