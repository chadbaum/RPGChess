# King behavior.
class King < Piece
  # Capture, check, and checkmate logic are not
  # implemented yet and thus ignored. Obstruction
  # logic is not necessary for the king.
  def valid_move?(x, y)
    moved?(x, y) && radial_move?(x, y) && !checked_cell?(x, y) &&
      (!game.black_check? || !game.white_check?)
  end

  # Returns true if the provided coords are on the line of
  # attack of any of the enemy piece.
  def checked_cell?(x, y)
    if color == 'white'
      black_pcs.each do |p|
        return true if p.valid_move?(x, y)
      end
    else
      white_pcs.each do |p|
        return true if p.valid_move?(x, y)
      end
    end
    false
  end

  private

  # selects all black or white pieces
  # used as helper method to avoid rubocop ABC
  # eror on checked_cell? method.
  def black_pcs
    game.pieces.select { |p| p.color == 'black' }
  end

  def white_pcs
    game.pieces.select { |p| p.color == 'white' }
  end

  # Returns true if the provided coordinates are within
  # 1 adjacent space of the king in any direction.
  def radial_move?(x, y)
    x_distance(x) <= 1 && y_distance(y) <= 1
  end
end
