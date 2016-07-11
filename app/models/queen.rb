class Queen < Piece

  def valid_move?(x, y) #does not include "castling" logic yet
    moved?(x,y) && (radial_move?(x,y) || horizontal_or_vertical_move?(x,y) || diagonal_move?(x,y))
  end
  
end
