class Bishop < Piece

  # Capture, collision, check, and checkmate logic are not
  # implemented yet and thus ignored.
  def valid_move?(x, y)
    moved?(x,y) && diagonal_move?(x,y)
  end

end
