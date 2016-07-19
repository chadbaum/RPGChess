class Pawn < Piece

  # Returns true if the pawn made a valid upgraded forward
  # move on its first move, or else a regular forward move.
  # Capture, collision, check, and checkmate logic are not
  # implemented yet and thus ignored.
  def valid_move?(x, y)
    moved ? forward_move?(x,y) : first_forward_move?(x,y)
  end

  # Updates the piece's type from Pawn to the new type
  # provided. Will need to be updated to check captured.
  def promote! (new_type)
    options = ["Bishop", "Knight", "Queen", "Rook"]
    raise ArgumentError unless options.include?(new_type)
    type == new_type
  end

  private

  # Returns true if the coordinates provided
  # are 1 tile forward from the piece's origin.
  def forward_move?(x,y)
    if color == 'black'
      x_distance(x) == 0 && y == y_position + 1
    else
      x_distance(x) == 0 && y == y_position - 1
    end
  end

  # Returns true if the coordinates provided
  # are 1-2 tiles forward from the piece's origin.
  def first_forward_move?(x,y)
    if color == 'black'
      x_distance(x) == 0 && (y == y_position + 1 || y == y_position + 2)
    else
      x_distance(x) == 0 && (y == y_position - 1 || y == y_position - 2)
    end
  end

end
