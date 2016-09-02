# King behavior.
class King < Piece
  # Capture, check, and checkmate logic are not
  # implemented yet and thus ignored. Obstruction
  # logic is not necessary for the king.
  def valid_move?(x, y)
    moved?(x, y) && !in_check?(x, y) &&
      (
        radial_move?(x, y) ||
        clear_castling_move?(x, y)
      )
  end

  #private

  # Returns true if the provided coordinates are within
  # 1 adjacent space of the king in any direction.
  def radial_move?(x, y)
    x_distance(x) <= 1 && y_distance(y) <= 1
  end

  def in_check?(x, y)
    enemy_pieces.each do |piece|
      return true if piece.valid_move?(x, y)
    end
    false
  end

  def in_checkmate?
    potential_moves = generate_radial_tiles
    potential_moves.each do |tile|
      if valid_move?(tile[0], tile[1]) && !in_check?(tile[0], tile[1])
        return false
      end
    end
    true
  end

  def generate_radial_tiles
    radial_tiles = []
    game.generate_tiles.each do |tile|
      if radial_move?(tile[0], tile[1]) && moved?(tile[0], tile[1])
        radial_tiles << tile
      end
    end
    radial_tiles
  end

  def enemy_pieces
    game.pieces.select { |piece| piece.color != color && piece.captured != true }
  end

  # Returns true if the king and rook have not moved,
  # the location is a valid castling target, and there is
  # no obstruction along the way. DOES NOT INCLUDE CHECK LOGIC.
  def clear_castling_move?(x, y)
    return false unless castling_coordinates?([x, y])
    return false if moved
    rook = castling_rook(x)
    return false unless rook
    distance = x_distance(rook.x_position)
    if path_clear?(rook.x_position, rook.y_position, distance) & !rook.moved
      rook.castling_move
      return true
    end
    false
  end

  # Returns true if coordinates are one of the two valid
  # castling destinations for each king.
  def castling_coordinates?(coordinates)
    options = if color == 'white'
                [[6, 7], [2, 7]]
              else
                [[6, 0], [2, 0]]
              end
    options.include?(coordinates)
  end

  # Returns the rook that would be castling with the king
  # based on whether the king is trying to castle left or right.
  def castling_rook(x)
    rook_x = x == 6 ? 7 : 0
    rook_y = color == 'white' ? 7 : 0
    game.pieces.find_by(x_position: rook_x, y_position: rook_y)
  end
end
