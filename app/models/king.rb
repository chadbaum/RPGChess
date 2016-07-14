class King < Piece

  # Returns true if the provided x-y coordinates are not the
  # same as the piece's initial x-y coordinates and if the
  # coordinates represent a valid radial move.  Capture, collision,
  # check, and checkmate logic are not implemented yet and thus ignored.
  def valid_move?(x, y)
    moved?(x,y) && radial_move?(x,y)
  end

  private

  # Returns true if the king is in its original location.
  # Note that this method will have to be replaced with a
  # boolean flag set in database to support castling properly
  # as it will improperly return true if king has moved out
  # of its initial position and back in.
  def first_move?
    x_position == 7 && y_position == 3 if color == "white"
    x_position == 0 && y_position == 3 if color == "black"
  end

  # Returns true if the provided x-y coordinates are within
  # 1 space of the king in any direction.
  def radial_move?(x,y)
    distance(x,"x") <= 1 && distance(y,"y") <= 1
  end

end
