class Pawn < Piece

  def valid_move?(x, y) #DOES NOT INCLUDE CAPTURE LOGIC YET
    first_forward_move?(x,y) if first_move?
    forward_move?(x,y)
  end

  def promote (new_type)
    options = ["Bishop", "Knight", "Queen", "Rook"]
    raise ArgumentError unless options.include?(new_type)
    type == new_type
  end

  private

  def first_move? #used for pawn movement bonus
    return true if color == "white" && x_position == 6
    return true if color == "black" && x_position == 1
  end

end
