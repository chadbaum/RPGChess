class Knight < Piece

  def valid_move?(x, y) #DOES NOT INCLUDE CAPTURE LOGIC YET
    moved?(x,y) && l_shaped_move?(x,y)
  end

end
