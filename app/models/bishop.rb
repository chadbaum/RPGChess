class Bishop < Piece

  def valid_move?(x, y) #NO CAPTURE/COLLISION LOGIC YET
    moved?(x,y) && diagonal_move?(x,y) #bishop moved any number of diagonal spaces
  end

end
