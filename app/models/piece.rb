# Piece superset behavior.
require 'pry'
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

  # First check if coordinates is taken
  # return false if coordinates belongs to friendly piece
  # otherwise return true
  # return false if position is not taken
  def capturable?(x,y)
    if position_taken?(x,y)
      if friendly_piece?(x,y)
        return false
      else
        return true
      end
    else
      return false
    end  
  end

  def capture!(x,y)
    if capturable?(x,y)
      target_piece(x,y).update_attributes(x_position: nil, y_position: nil, captured: true)
    end
  end

  # Return true if target is a friendly piece
  # otherwise return false
  def friendly_piece?(x,y)
    return true if color == target_piece(x,y).color
    false
  end

  # Find the target piece base on game id, and x,y coordinates
  def target_piece(x,y)
    Piece.find_by(game_id: game_id, x_position: x, y_position: y)
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

  # Return true if target coordinates is taken base on game id and x,y coordinates
  def position_taken?(x,y)
    Piece.find_by(game_id: game_id, x_position: x, y_position: y).present?
  end
end
