# Bishop behavior.
class Bishop < Piece
  # Capture, check, and checkmate logic are not
  # implemented yet and thus ignored.
  def valid_move?(x, y)
    return false unless game.occupied?(x, y) ? capturable?(x, y) : true
    clear_diagonal_move?(x, y)
  end
end
