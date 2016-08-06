# model Game,piece creation inside
# DO NOT chnage the sequence of methods
# or you will break the front end view
class Game < ActiveRecord::Base
  has_many :pieces
  has_many :players
  has_many :users, through: :players
  after_create :create_players!

  def populate!
    populate_left_black_half!
    populate_right_black_half!
    populate_black_pawns!
    populate_white_pawns!
    populate_left_white_half!
    populate_right_white_half!
  end

  private

  def create_players!
    create_players(color: 'white')
    create_players(color: 'black')
  end

  def white
    players.find_by(color: 'white')
  end

  def black
    players.find_by(color: 'black')
  end

  def populate_left_black_half!
    black.pieces.create(type: 'Rook', x_position: 0, y_position: 0, color: 'black')
    black.pieces.create(type: 'Knight', x_position: 1, y_position: 0, color: 'black')
    black.pieces.create(type: 'Bishop', x_position: 2, y_position: 0, color: 'black')
    black.pieces.create(type: 'Queen', x_position: 3, y_position: 0, color: 'black')
  end

  def populate_right_black_half!
    black.pieces.create(type: 'King', x_position: 4, y_position: 0, color: 'black')
    black.pieces.create(type: 'Bishop', x_position: 5, y_position: 0, color: 'black')
    black.pieces.create(type: 'Knight', x_position: 6, y_position: 0, color: 'black')
    black.pieces.create(type: 'Rook', x_position: 7, y_position: 0, color: 'black')
  end

  def populate_black_pawns!
    (0..7).each do |i|
      black.pieces.create(type: 'Pawn', x_position: i, y_position: 1, color: 'black')
    end
  end

  def populate_white_pawns!
    (0..7).each do |j|
      white.pieces.create(type: 'Pawn', x_position: j, y_position: 6, color: 'white')
    end
  end

  def populate_left_white_half!
    white.pieces.create(type: 'Rook', x_position: 0, y_position: 7, color: 'white')
    white.pieces.create(type: 'Knight', x_position: 1, y_position: 7, color: 'white')
    white.pieces.create(type: 'Bishop', x_position: 2, y_position: 7, color: 'white')
    white.pieces.create(type: 'Queen', x_position: 3, y_position: 7, color: 'white')
  end

  def populate_right_white_half!
    white.pieces.create(type: 'King', x_position: 4, y_position: 7, color: 'white')
    white.pieces.create(type: 'Bishop', x_position: 5, y_position: 7, color: 'white')
    white.pieces.create(type: 'Knight', x_position: 6, y_position: 7, color: 'white')
    white.pieces.create(type: 'Rook', x_position: 7, y_position: 7, color: 'white')
  end
end
