# Bishop behavior.
class Bishop < Piece
  # Capture, check, and checkmate logic are not
  # implemented yet and thus ignored.
  def valid_move?(x, y)
    if game.occupied?(x, y) ? capturable?(x, y) : true
      clear_diagonal_move?(x, y)
    end
  end

  def generate_moveset_tiles
    moveset_tiles = []
    game.generate_tiles.each do |tile|
      if valid_move?(tile[0], tile[1])
        moveset_tiles << tile
      end
    end
    moveset_tiles
  end

end
