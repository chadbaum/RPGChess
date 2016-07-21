# Piece superset behavior.
class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  validates :color, inclusion: { in: %w(black white) }
  validates :type, inclusion: { in: %w(Pawn Rook Bishop Knight King Queen) }

  # Returns true, updates the piece's x and y position
  # to provided coordinates if move is valid, and sets
  # the moved flag to true otherwise do nothing and
  # return false.
  def move!(x, y)
    return false unless valid_move?(x, y)
    self.x_position = x
    self.y_position = y
    self.moved = true
    true
  end

  # All validation assumes white player is on the
  # 6-7 rows of the array, and black player is on
  # 0-1 rows of the array.

  private

  # Compares a piece's x_position with the
  # coordinate provided and returns the
  # distance between the two.
  def x_distance(new_x_coordinate)
    (x_position - new_x_coordinate).abs
  end

  # Compares a piece's y_position with the
  # coordinate provided and returns the
  # distance between the two.
  def y_distance(new_y_coordinate)
    (y_position - new_y_coordinate).abs
  end

  # Returns true if the coordinates provided
  # are different from the piece's starting
  # position.
  def moved?(x, y)
    x != x_position || y != y_position
  end

  # Returns true if the coordinates provided
  # have the same x-axis value and there are no
  # pieces in between.
  def horizontal_move?(x, y)
    return false unless y_distance(y) == 0
    range = (x_position + 1)...x if x_position < x #right
    range = (x + 1)...x_position if x_position > x #left
    range.each do |x_coordinate_between|
      return false if game.pieces.find_by(x_position: x_coordinate_between, y_position: y)
    end
  end

  # Returns true if the coordinates provided
  # have the same y-axis value and there are no
  # pieces in between.
  def vertical_move?(x, y)
    return false unless x_distance(x) == 0
    range = (y_position + 1)...y if y_position < y #down
    range = (y + 1)...y_position if y_position > y #up
    range.each do |y_coordinate_between|
      return false if game.pieces.find_by(y_position: y_coordinate_between, x_position: x)
    end
  end

  # Returns true if the coordinates provided
  # are the same distance away from the
  # origin point along both axis.
  def diagonal_move?(y)
    x_distance(x) == y_distance(y)
  end
end
