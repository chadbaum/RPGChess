class Game < ActiveRecord::Base
  has_many :pieces
  has_many :players

  after_create :populate_board!

  def populate_board!


    # Black Pieces of the board
    (0..7).each do |i|
      Pawn.create(game_id: id, x_position: i, y_position: 1, color: "black")
    end

    Rook.create(game_id: id, x_position: 0, y_position: 0, color: "black")
    Rook.create(game_id: id, x_position: 7, y_position: 0, color: "black")

    Knight.create(game_id: id, x_position: 1, y_position: 0, color: "black")
    Knight.create(game_id: id, x_position: 6, y_position: 0, color: "black")

    Bishop.create(game_id: id, x_position: 2, y_position: 0, color: "black")
    Bishop.create(game_id: id, x_position: 5, y_position: 0, color: "black")

    Queen.create(game_id: id, x_position: 3, y_position: 0, color: "black")
    King.create(game_id: id, x_position: 4, y_position: 0, color: "black")


    # White Pieces of the board
    (0..7).each do |i|
      Pawn.create(game_id: id, x_position: i, y_position: 6, color: "white")
    end

    Rook.create(game_id: id, x_position: 0, y_position: 7, color: "white")
    Rook.create(game_id: id, x_position: 7, y_position: 7, color: "white")

    Knight.create(game_id: id, x_position: 1, y_position: 7, color: "white")
    Knight.create(game_id: id, x_position: 6, y_position: 7, color: "white")
    Bishop.create(game_id: id, x_position: 2, y_position: 7, color: "white")
    Bishop.create(game_id: id, x_position: 5, y_position: 7, color: "white")
    Queen.create(game_id: id, x_position: 3, y_position: 7, color: "white")
    King.create(game_id: id, x_position: 4, y_position: 7, color: "white")


  end

  
end
