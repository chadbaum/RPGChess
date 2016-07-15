class Knight < Piece

  # Capture, collision, check, and checkmate logic are not
  # implemented yet and thus ignored.
  def valid_move?(x,y)
    moved?(x,y) && l_shaped_move?(x,y)
  end

  private

  # Returns true if the coordinates provided are either
  # 2 tiles away from the x_position along the x_axis and
  # 1 tile away from the y_position along the y_axis OR 1 tile
  # away from the x_position along the x_axis and 2 tiles
  # away from the y_position along the y_axis
  def l_shaped_move?(x,y)
    (x_distance(x) == 2 && y_distance(y) == 1) || (x_distance(x) == 1 && y_distance(y) == 2)
  end

end
