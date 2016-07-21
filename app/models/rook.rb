# Rook behavior.
class Rook < Piece
  # Capture, collision, check, and checkmate logic are not
  # implemented yet and thus ignored.  We will need a boolean
  # to store whether a piece has ever moved for rook and king
  # castling logic.
  def valid_move?(x, y)
    moved?(x, y) && (horizontal_move?(x, y) || vertical_move?(x, y))
  end
end
