class Knight < Piece

  def valid_move?(x,y) #DOES NOT INCLUDE CAPTURE LOGIC YET
    moved?(x,y) && l_shaped_move?(x,y)
  end

  private

  def l_shaped_move?(x,y) #validates a move in an L-shape
    (distance(x,"x") == 2 && distance(y,"y") == 1) || (distance(x,"x") == 1 && distance(y,"y") == 2)
  end

end
