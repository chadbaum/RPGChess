# Pawn behavior.
class Pawn < Piece
  # Returns true if the pawn made a valid upgraded forward
  # move on its first move, or else a regular forward move,
  # and ensure no capture takes place by moving forward.
  # Check, and checkmate logic are not implemented yet
  # and thus ignored.
  def valid_move?(x, y)
    (moved ? one_forward_move?(x, y) : first_forward_move?(x, y)) &&
      !forward_capture?(x, y)
  end

  # Updates the piece's type from Pawn to the new type
  # provided. Will need to be updated to check captured.
  def promote!(new_type)
    options = %w(Bishop Knight Queen Rook)
    raise ArgumentError unless options.include?(new_type)
    type == new_type
  end

  private

  # Returns true if the coordinates provided
  # are 1 tile forward from the piece's origin.
  def one_forward_move?(x, y)
    if color == 'black'
      x_distance(x) == 0 && y == y_position + 1
    else
      x_distance(x) == 0 && y == y_position - 1
    end
  end

  # Returns true if coordinates provided are
  # 2 tiles forward from the piece's origin.
  def clear_two_forward_move?(x, y)
    if color == 'black'
      x_distance(x) == 0 && y == y_position + 2 && path_clear?(x, y, 2)
    else
      x_distance(x) == 0 && y == y_position - 2 && path_clear?(x, y, 2)
    end
  end

  # Returns true if the coordinates provided
  # are 1-2 tiles forward from the piece's origin.
  def first_forward_move?(x, y)
    one_forward_move?(x, y) || clear_two_forward_move?(x, y)
  end

  # Returns true if there is any piece present
  # in the tile provided.  Will be refactored when
  # merged with capture logic.
  def forward_capture?(x, y)
    game.pieces.find_by(
      x_position: x,
      y_position: y
    )
  end
end
