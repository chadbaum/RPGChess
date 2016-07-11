class Rook < Piece

  def valid_move?(x, y) #NO CAPTURE/COLLISION LOGIC YET
    moved?(x,y) && horizontal_or_vertical_move?(x,y)
  end

  #WE NEED A BOOLEAN IN DATABASE TO SUPPORT WHETHER OR NOT ROOK HAS EVER MOVED FOR "CASTLING" LOGIC. -Chad

end
