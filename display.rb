require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display

  def initialize(board, current_pos, selected_pos, messages = Hash.new)
    @board = board
    @current_pos, @selected_pos = current_pos, selected_pos
    @messages = messages
  end

  def get_input
    cursor = Cursor.new(current_pos, board)
    until cursor.selected?
      render
      self.current_pos = cursor.get_input
      system 'clear'
    end
    current_pos
  end

  def pos_highlight(pos)
    case pos
    when current_pos
      :red
    when selected_pos
      :blue
    end
  end

  def print_board
    board.grid.each.with_index do |row, row_idx|
      print " "
      row.each.with_index do |piece, col_idx|
        highlight_color = pos_highlight([row_idx, col_idx])
        print piece.to_s.colorize(highlight_color)
        print " "
      end
      puts ""
    end
  end

  def render
    puts messages[:start]
    print_board
    puts messages[:errors]
  end

  private

  attr_accessor :current_pos
  attr_reader :board, :selected_pos
  attr_reader :messages
end
