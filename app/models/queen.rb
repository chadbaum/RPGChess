class Queen < Piece

  def valid_move?(x, y)
    moved?(x,y) && (horizontal_move?(x,y) || vertical_move?(x,y) || diagonal_move?(x,y))
  end

end
