# model Game,piece creation inside
class Game < ActiveRecord::Base
  has_many :pieces
  has_many :players

  def populate!
    populate_pawns!
    populate_knights!
    populate_bishops!
    populate_rooks!
    populate_queens!
    populate_kings!
  end

  private

  def populate_pawns!
    (0..7).each do |i|
      pieces.create(type: 'Pawn', x_position: i, y_position: 1, color: 'black')
    end
    (0..7).each do |i|
      pieces.create(type: 'Pawn', x_position: i, y_position: 6, color: 'white')
    end
  end

  def populate_knights!
    pieces.create(type: 'Knight', x_position: 1, y_position: 7, color: 'white')
    pieces.create(type: 'Knight', x_position: 6, y_position: 7, color: 'white')
    pieces.create(type: 'Knight', x_position: 1, y_position: 0, color: 'black')
    pieces.create(type: 'Knight', x_position: 6, y_position: 0, color: 'black')
  end

  def populate_bishops!
    pieces.create(type: 'Bishop', x_position: 2, y_position: 7, color: 'white')
    pieces.create(type: 'Bishop', x_position: 5, y_position: 7, color: 'white')
    pieces.create(type: 'Bishop', x_position: 2, y_position: 0, color: 'black')
    pieces.create(type: 'Bishop', x_position: 5, y_position: 0, color: 'black')
  end

  def populate_rooks!
    pieces.create(type: 'Rook', x_position: 0, y_position: 7, color: 'white')
    pieces.create(type: 'Rook', x_position: 7, y_position: 7, color: 'white')
    pieces.create(type: 'Rook', x_position: 0, y_position: 0, color: 'black')
    pieces.create(type: 'Rook', x_position: 7, y_position: 0, color: 'black')
  end

  def populate_queens!
    pieces.create(type: 'Queen', x_position: 3, y_position: 7, color: 'white')
    pieces.create(type: 'Queen', x_position: 3, y_position: 0, color: 'black')
  end

  def populate_kings!
    pieces.create(type: 'King', x_position: 4, y_position: 7, color: 'white')
    pieces.create(type: 'King', x_position: 4, y_position: 0, color: 'black')
  end
end
