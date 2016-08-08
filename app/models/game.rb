# model Game,piece creation inside
# DO NOT chnage the sequence of methods
# or you will break the front end view
class Game < ActiveRecord::Base
  has_many :pieces
  has_many :players

  def populate!
    populate_left_black_half!
    populate_right_black_half!
    populate_black_pawns!
    populate_white_pawns!
    populate_left_white_half!
    populate_right_white_half!
  end

  def check?(color)
    king = pieces.find_by(type: 'King', color: color)
    enemy_pcs(color).each do |p|
      return true if p.valid_move?(king.x_position, king.y_position)
    end
    false
  end

  # selects enemy pieces that are not captured
  def enemy_pcs(color)
    pieces.select { |p| p.color != color && p.captured != true }
  end

  private

  def populate_left_black_half!
    pieces.create(type: 'Rook', x_position: 0, y_position: 0, color: 'black')
    pieces.create(type: 'Knight', x_position: 1, y_position: 0, color: 'black')
    pieces.create(type: 'Bishop', x_position: 2, y_position: 0, color: 'black')
    pieces.create(type: 'Queen', x_position: 3, y_position: 0, color: 'black')
  end

  def populate_right_black_half!
    pieces.create(type: 'King', x_position: 4, y_position: 0, color: 'black')
    pieces.create(type: 'Bishop', x_position: 5, y_position: 0, color: 'black')
    pieces.create(type: 'Knight', x_position: 6, y_position: 0, color: 'black')
    pieces.create(type: 'Rook', x_position: 7, y_position: 0, color: 'black')
  end

  def populate_black_pawns!
    (0..7).each do |i|
      pieces.create(type: 'Pawn', x_position: i, y_position: 1, color: 'black')
    end
  end

  def populate_white_pawns!
    (0..7).each do |j|
      pieces.create(type: 'Pawn', x_position: j, y_position: 6, color: 'white')
    end
  end

  def populate_left_white_half!
    pieces.create(type: 'Rook', x_position: 0, y_position: 7, color: 'white')
    pieces.create(type: 'Knight', x_position: 1, y_position: 7, color: 'white')
    pieces.create(type: 'Bishop', x_position: 2, y_position: 7, color: 'white')
    pieces.create(type: 'Queen', x_position: 3, y_position: 7, color: 'white')
  end

  def populate_right_white_half!
    pieces.create(type: 'King', x_position: 4, y_position: 7, color: 'white')
    pieces.create(type: 'Bishop', x_position: 5, y_position: 7, color: 'white')
    pieces.create(type: 'Knight', x_position: 6, y_position: 7, color: 'white')
    pieces.create(type: 'Rook', x_position: 7, y_position: 7, color: 'white')
  end
end
