# Pawn behavior.
class Pawn < Piece
  # Returns true if the pawn made a valid upgraded forward
  # move on its first move, or a regular forward move, or
  # a capture by attacking diagonally. Ensures no capture
  # takes place by moving forward. Check, and checkmate logic
  # are not implemented yet and thus ignored.
  def valid_move?(x, y)
    return true if fwd_diagonal_attack?(x, y)
    return true if en_passant?(x, y)
    moved ? one_fwd_move?(x, y) : first_fwd_move?(x, y) && !fwd_attack?(x, y)
  end

  # En Passant Logic:
  # 1)target pawn just moved 2 space forward
  # 2)only capture within the next turn
  # 3)can only capture by opponent's pawn
  # 4)opponent pawn must be on the left or right of target piece's y axis

  # return false if last move piece is nil (Start of game)
  # return false last moved piece is not pawn or its y axis difference is !2
  # check both both adjacent side of pawn
  # if any have valid En Passant pawn piece, return true
  def en_passant?(x, y)
    return false if last_moved_piece.nil?
    return false unless last_moved_piece.y_distance(y - 2) == 2 &&
    type == 'Pawn'
    [valid_en_passant_pawn?(x, y, true), valid_en_passant_pawn?(x, y, false)]
    .include?(true)
  end

  # Updates the piece's type from Pawn to the new type
  # provided.
  def promote!(new_type)
    options = %w(Bishop Knight Queen Rook)
    raise ArgumentError unless options.include?(new_type)
    update(type: new_type)
  end

  private

  # check for any adjacent piece
  # return false if none if found
  # return true if opponent's pawn is found
  def valid_en_passant_pawn?(x, y, adjacent)
    adjacent_piece = occupant_piece(x + (adjacent ? 1 : -1), y)
    return false if adjacent_piece.nil?
    return true if adjacent_piece.type ==
    'Pawn' && adjacent_piece.color != color
    false
  end

  # Returns true if the coordinates provided are 1 tile forward
  # from the piece's origin and no capture occured.
  def one_fwd_move?(x, y)
    if color == 'black'
      x_distance(x) == 0 && y == y_position + 1
    else
      x_distance(x) == 0 && y == y_position - 1
    end
  end

  # Returns true if coordinates provided are 2 tiles forward
  # from the piece's origin and no capture occurred.
  def clear_two_fwd_move?(x, y)
    if color == 'black'
      x_distance(x) == 0 && y == y_position + 2 && path_clear?(x, y, 2)
    else
      x_distance(x) == 0 && y == y_position - 2 && path_clear?(x, y, 2)
    end
  end

  # Returns true if the coordinates provided
  # are 1-2 tiles forward from the piece's origin.
  def first_fwd_move?(x, y)
    one_fwd_move?(x, y) || clear_two_fwd_move?(x, y)
  end

  # Returns true if a piece exists in pawn's forward path.
  def fwd_attack?(x, y)
    game.pieces.exists?(x_position: x, y_position: y)
  end

  # Returns true if pawn is moving into an enemy-occupied tile
  # that is one space diagonally forward to the left or right
  # of the pawn's starting position.
  def fwd_diagonal_attack?(x, y)
    return true if en_passant?(x, y)
    return false unless occupant_piece(x, y)
    return false unless x == x_position + 1 || x == x_position - 1
    y == if color == 'black'
      y_position + 1
    else
      y_position - 1
    end
  end

  # find the last moved piece by subtracting current move number - 1
  def last_moved_piece
    game.pieces.find_by(last_moved_piece: game.move_number - 1)
  end
end
