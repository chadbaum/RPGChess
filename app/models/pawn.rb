# Pawn behavior.
require 'pry'
class Pawn < Piece
  # Returns true if the pawn made a valid upgraded forward
  # move on its first move, or else a regular forward move,
  # and ensure no capture takes place by moving forward.
  # Check, and checkmate logic are not implemented yet
  # and thus ignored. Diagonal attack not implemented.
  def valid_move?(x, y)
    (moved ? one_forward_move?(x, y) : first_forward_move?(x, y)) &&
    !forward_capture?(x, y)
  end

  # En Passant Logic:
  # 1)target pawn just moved 2 space forward
  # 2)only capture within the next turn
  # 3)can only capture by opponent's pawn
  # 4)opponent pawn must be on the left or right of target piece's y axis
  
  def en_passant?(x, y)
    return false if last_moved_piece.nil?
    return false unless last_moved_piece.y_distance(y-2) == 2 && type == 'Pawn'
    [valid_en_passant_pawn?(x, y, true), valid_en_passant_pawn?(x, y, false)].include?(true)
  end

  def valid_en_passant_pawn?(x, y, adjacent)
    adjacent_piece = occupant_piece(x + (adjacent ? 1 : -1), y)
    return false if adjacent_piece.nil?
    return true if adjacent_piece.type == 'Pawn' && adjacent_piece.color != color
    false
  end

  def last_moved_piece
    game.pieces.find_by(last_moved_piece: game.move_number - 1)
  end

  # Updates the piece's type from Pawn to the new type
  # provided.
  def promote!(new_type)
    options = %w(Bishop Knight Queen Rook)
    raise ArgumentError unless options.include?(new_type)
    type == new_type
  end

  private

  # Returns true if the coordinates provided are 1 tile forward
  # from the piece's origin and no capture occured.
  def one_forward_move?(x, y)
    if color == 'black'
      x_distance(x) == 0 && y == y_position + 1
    else
      x_distance(x) == 0 && y == y_position - 1
    end
  end

  # Returns true if coordinates provided are 2 tiles forward
  # from the piece's origin and no capture occurred.
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

  def forward_capture?(x, y)
    game.pieces.exists?(x_position: x, y_position: y)
  end
end
