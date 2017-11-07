module SlidingPiece

  DIAGNALS = [[-1, -1], [1, 1], [-1, 1], [1, -1]].freeze
  LATERALS = [[-1, 0], [1, 0], [0, 1], [0, -1]].freeze

  def moves
    moves = []
    diffs.each do |diff|
      until !Board.in_bounds?(pos) || board.piece_color(pos) == color
        pos ||= diff
        moves << pos
        break if board.is_occupied?(pos)
        pos = diff.map { |diff_coord, idx| diff_coord + pos[idx] }
      end
    end
    moves
  end

  def diffs
    dirs.each do |diff|
      diff.map { |axis_diff, idx| axis_diff + position[idx] }
    end
  end

end
