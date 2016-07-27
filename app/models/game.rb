# model Game,piece creation inside
class Game < ActiveRecord::Base
  has_many :pieces
  has_many :players

  after_create :populate_bishops!, :populate_rooks!, :populate_pawns!,\
               :populate_knights!, :populate_queens_kings!

  def populate_first_black_half!
    pieces.create(type: 'Rook', x_position: 0, y_position: 0, color: 'black')
    pieces.create(type: 'Knight', x_position: 1, y_position: 0, color: 'black')
    pieces.create(type: 'Bishop', x_position: 2, y_position: 0, color: 'black')
    pieces.create(type: 'Queen', x_position: 3, y_position: 0, color: 'black')
  end

  def populate_second_black_half!
    pieces.create(type: 'King', x_position: 4, y_position: 0, color: 'black')
    pieces.create(type: 'Bishop', x_position: 5, y_position: 0, color: 'black')
    pieces.create(type: 'Knight', x_position: 6, y_position: 0, color: 'black')
    pieces.create(type: 'Rook', x_position: 7, y_position: 0, color: 'black')
  end

  def populate_black_pawns!
    (0..7).each do |i|
      pieces.create(type: 'Pawn', x_position: i, y_position: 1, color: 'black')
  end

  def populate_white_pawns!
    (0..7).each do |j|
      pieces.create(type: 'Pawn', x_position: j, y_position: 6, color: 'white')
  end

  def populate_first_white_half!
    pieces.create(type: 'Rook', x_position: 0, y_position: 7, color: 'white')
    pieces.create(type: 'Knight', x_position: 1, y_position: 7, color: 'white')
    pieces.create(type: 'Bishop', x_position: 2, y_position: 7, color: 'white')
    pieces.create(type: 'Queen', x_position: 3, y_position: 7, color: 'white')
  end

  def populate_second_white_half!
    pieces.create(type: 'Knight', x_position: 6, y_position: 7, color: 'white')
    pieces.create(type: 'King', x_position: 4, y_position: 7, color: 'white')
    pieces.create(type: 'Bishop', x_position: 5, y_position: 7, color: 'white')
    pieces.create(type: 'Rook', x_position: 7, y_position: 7, color: 'white')
  end

end
