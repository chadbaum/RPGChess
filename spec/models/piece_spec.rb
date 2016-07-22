require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe 'moved flag for piece' do
    it 'should return false if piece has never moved' do
      bishop = FactoryGirl.create(:bishop, :white)

      expect(bishop.moved).to eq false
    end

    it 'should return true if piece has moved' do
      bishop = FactoryGirl.create(:bishop, :white)

      bishop.move!(3, 6)

      expect(bishop.moved).to eq true
    end
  end

  describe 'capturable?' do
    it 'return false if specified coordinates not occupied by any piece' do
      game = FactoryGirl.create(:game)
      white_pawn = FactoryGirl.create(:pawn, :white, game_id: game.id)

      expect(white_pawn.capturable?(4, 5)).to eq false
    end

    it 'return false if specified coordinates occupied by same color piece' do
      game = empty_game
      white_pawn = FactoryGirl.create(
        :pawn,
        :white,
        game_id: game.id,
        x_position: 3,
        y_position: 0,
        captured: false
      )
      other_white_pawn = FactoryGirl.create(
        :pawn,
        :white,
        game_id: game.id,
        x_position: 4,
        y_position: 1,
        captured: false
      )

      expect(other_white_pawn.capturable?(
               white_pawn.x_position,
               white_pawn.y_position
      )).to eq false
    end

    it 'return true if specified coordinates occupied by target piece' do
      game = empty_game
      black_rook = FactoryGirl.create(
        :rook,
        :black,
        game_id: game.id,
        x_position: 4,
        y_position: 0,
        captured: false
      )
      white_pawn = FactoryGirl.create(
        :pawn,
        :white,
        game_id: game.id,
        x_position: 4,
        y_position: 1,
        captured: false
      )

      expect(white_pawn.capturable?(
               black_rook.x_position,
               black_rook.y_position
      )).to eq true
    end
  end

  describe 'capture!' do
    it 'update target piece attributes' do
      game = empty_game
      black_rook = FactoryGirl.create(
        :rook,
        :black,
        game_id: game.id,
        x_position: 3,
        y_position: 1,
        captured: false
      )
      white_pawn = FactoryGirl.create(
        :pawn,
        :white,
        game_id: game.id,
        x_position: 4,
        y_position: 1,
        captured: false
      )

      black_rook.capture!(white_pawn.x_position, white_pawn.y_position)

      white_pawn.reload

      expect(white_pawn.x_position).to eq nil
      expect(white_pawn.y_position).to eq nil
      expect(white_pawn.captured).to eq true
    end
  end

  describe 'friendly_piece?' do
    it 'return true if target piece have the same color' do
      game = empty_game
      white_pawn = FactoryGirl.create(
        :pawn,
        :white,
        game_id: game.id,
        x_position: 3,
        y_position: 0,
        captured: false
      )
      other_white_pawn = FactoryGirl.create(
        :pawn,
        :white,
        game_id: game.id,
        x_position: 4,
        y_position: 1,
        captured: false
      )

      expect(other_white_pawn.friendly_piece?(
               white_pawn.x_position,
               white_pawn.y_position
      )).to eq true
    end
  end

  # before create a new game, destory all pieces pre-populated from game model
  def empty_game
    game = FactoryGirl.create(:game)
    game.pieces.destroy_all
    game.reload
    game
  end
end
