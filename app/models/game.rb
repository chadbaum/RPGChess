class Game < ActiveRecord::Base
  after_create :populate_board!

  has_many :pieces
  has_many :players

  

  def populate_board!


    # Black Pieces of the board
    (0..7).each do |i|
      Pawn.create(game_id: id,x_position: i,y_position: 1)
    end

    Rook.create(game_id: id, x_position: 0, y_position: 0)
    Rook.create(game_id: id, x_position: 7, y_position: 0)

    Knight.create(game_id: id, x_position: 1, y_position: 0)
    Knight.create(game_id: id, x_position: 6, y_position: 0)

    Bishop.create(game_id: id, x_position: 2, y_position: 0)
    Bishop.create(game_id: id, x_position: 5, y_position: 0)

    Queen.create(game_id: id, x_position: 3, y_position: 0)
    King.create(game_id: id, x_position: 4, y_position: 0)


    # White Pieces of the board
    (0..7).each do |i|
      Pawn.create(game_id: id,x_position: i,y_position: 6)
    end

    Rook.create(game_id: id, x_position: 0, y_position: 7)
    Rook.create(game_id: id, x_position: 7, y_position: 7)

    Knight.create(game_id: id, x_position: 1, y_position: 7)
    Knight.create(game_id: id, x_position: 6, y_position: 7)
    Bishop.create(game_id: id, x_position: 2, y_position: 7)
    Bishop.create(game_id: id, x_position: 5, y_position: 7)
    Queen.create(game_id: id, x_position: 3, y_position: 7)
    King.create(game_id: id, x_position: 4, y_position: 7)


  end

  
end
