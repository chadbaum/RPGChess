class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  validates :color, inclusion: { in: %w(black white) }
  validates :type, inclusion: { in: %w(Pawn Rook Bishop Knight King Queen) }

  private

  #ALL MOVE CHECKS ASSUME WHITE PLAYER IS AT BOTTOM OF 2-D ARRAY/BOARD, AND BLACK PLAYER IS ON TOP.  NO IMPACT ON VIEW. -Chad

  def x_distance(x) #calculates how many tiles piece has moved on x-axis
    (x_position - x).abs
  end

  def y_distance(y) #calculates how many tiles piece has moved on y-axis
    (y_position - y).abs
  end

  def moved?(x,y) #validates whether piece is at its origin position
    x != x_position || y != y_position
  end

  def horizontal_or_vertical_move?(x,y) #validates a move any amount of spaces along one axis
    (x_distance(x) == 0 || y_distance(y) == 0)
  end

  def diagonal_move?(x,y) #validates a move any amount of spaces along a diagonal
    x_distance(x) == y_distance(y)
  end

  def radial_move?(x,y) #validates a move 1 space in any direction
    x_distance(x) < 2 && y_distance(y) < 2
  end

  def forward_move?(x,y) #validates a move 1 space forward
    x == x_position + 1 if color == 'black'
    x == x_position - 1 if color == 'white'
  end

  def first_forward_move?(x,y) #validates a move 1-2 spaces forward
    y == y_position && (x == x_position + 1 || x == x_position + 2) if color == 'black'
    y == y_position && (x == x_position - 1 || x == x_position - 2) if color == 'white'
  end

  def l_shaped_move?(x,y) #validates a move in an L-shape
    (x_distance(x) == 2 && y_distance(y) == 1) || (x_distance(x) == 1 && y_distance(y) == 2)
  end

end
