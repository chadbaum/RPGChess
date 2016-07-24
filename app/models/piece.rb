# Piece superset behavior.
class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  validates :color, inclusion: { in: %w(black white) }
  validates :type, inclusion: { in: %w(Pawn Rook Bishop Knight King Queen) }

  # Returns true and updates the piece's x and
  # y position to provided coordinates if move is valid,
  # otherwise do nothing and return false.
  def move!(x, y)
    return false unless valid_move?(x, y)
    self.x_position = x
    self.y_position = y
    self.moved = true
    true
  end

  # Return false if coordinates is taken but belongs to friendly piece
  # otherwise return true
  def capturable?(x, y)
    return false unless position_taken?(x, y) && !friendly_piece?(x, y)
    true
  end

  # if piece is capturable change piece's attributes
  def capture!(x, y)
    return false unless capturable?(x, y)
    move!(x, y)
    target_piece(x, y).update_attributes!(
      x_position: nil,
      y_position: nil,
      captured: true
    )
  end

  # Return true if target is a friendly piece
  # otherwise return false
  def friendly_piece?(x, y)
    color == target_piece(x, y).color
  end

  # Find the target piece base on it x and y coordinates
  def target_piece(x, y)
    game.pieces.find_by(x_position: x, y_position: y)
  end

  # All validation assumes white player is on the
  # 6-7 rows of the array, and black player is on
  # 0-1 rows of the array.

  private

  # check if position is taken by any piece
  def position_taken?(x, y)
    game.pieces.find_by(x_position: x, y_position: y).present?
  end

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
  # have the same x-axis value.
  def horizontal_move?(x)
    x_distance(x) == 0
  end

  # Returns true if the coordinates provided
  # have the same y-axis value.
  def vertical_move?(y)
    y_distance(y) == 0
  end

  # Returns true if the coordinates provided
  # are the same distance away from the
  # origin point along both axis.
  def diagonal_move?(x, y)
    x_distance(x) == y_distance(y)
  end
end
