class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  validates :color, inclusion: { in: %w(black white) }
  validates :type, inclusion: { in: %w(Pawn Rook Bishop Knight King Queen) }

  private

  #ALL MOVE CHECKS ASSUME WHITE PLAYER IS AT BOTTOM OF 2-D ARRAY/BOARD, AND BLACK PLAYER IS ON TOP.  NO IMPACT ON VIEW. -Chad

  def distance(destination, x_or_y) #calculates how many tiles piece has moved on x-axis or y-axis
    raise ArgumentError unless x_or_y == "x" || x_or_y == "y"
    (x_position - destination).abs if x_or_y == "x"
    (y_position - destination).abs if x_or_y == "y"
  end

  def moved?(x,y) #validates whether piece is at its origin position
    x != x_position || y != y_position
  end

  def horizontal_or_vertical_move?(x,y) #validates a move any amount of spaces along one axis; used for Rook and Queen
    (distance(x,"x") == 0 || distance(y,"y") == 0)
  end

  def diagonal_move?(x,y) #validates a move any amount of spaces along a diagonal; used for Bishop and Queen
    distance(x,"x") == distance(y,"y")
  end

end
