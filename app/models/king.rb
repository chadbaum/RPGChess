class King < Piece

  def valid_move?(x, y) #does not include "castling" logic yet or check logic
    moved?(x,y) && radial_move?(x,y)
  end

  private

  def first_move? #will be used for "castling" logic, needs a database boolean check instead, this method will not work if king moves back into original spot
    x_position == 7 && y_position == 3 if color == "white"
    x_position == 0 && y_position == 3 if color == "black"
  end

  def radial_move?(x,y)
    distance(x,"x") <= 1 && distance(y,"y") <= 1
  end

end
