require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe 'capturable?' do
    before(:each) do
      @game = FactoryGirl.create :empty_chess_board
    end

    it 'should return false if coordinates not occupied by any piece' do
      white_pawn = FactoryGirl.create(:pawn, :white, game_id: @game.id)

      expect(white_pawn.capturable?(4, 5)).to eq false
    end

    it 'should return false if coordinates occupied by same color piece' do
      white_pawn = FactoryGirl.create(
        :pawn,
        :white,
        game_id: @game.id,
        x_position: 3,
        y_position: 0,
        captured: false
      )
      other_white_pawn = FactoryGirl.create(
        :pawn,
        :white,
        game_id: @game.id,
        x_position: 4,
        y_position: 1,
        captured: false
      )

      expect(other_white_pawn.capturable?(
               white_pawn.x_position,
               white_pawn.y_position
      )).to eq false
    end

    it 'should return true if coordinates occupied by target piece' do
      black_rook = FactoryGirl.create(
        :rook,
        :black,
        game_id: @game.id,
        x_position: 4,
        y_position: 0,
        captured: false
      )
      white_pawn = FactoryGirl.create(
        :pawn,
        :white,
        game_id: @game.id,
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
    before(:each) do
      @game = FactoryGirl.create :empty_chess_board
    end

    it 'should update target piece attributes' do
      black_rook = FactoryGirl.create(
        :rook,
        :black,
        game_id: @game.id,
        x_position: 3,
        y_position: 1,
        captured: false
      )
      white_pawn = FactoryGirl.create(
        :pawn,
        :white,
        game_id: @game.id,
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

    it 'should update our piece attributes' do
      black_rook = FactoryGirl.create(
        :rook,
        :black,
        game_id: @game.id,
        x_position: 3,
        y_position: 1,
        captured: false
      )
      white_pawn = FactoryGirl.create(
        :pawn,
        :white,
        game_id: @game.id,
        x_position: 4,
        y_position: 1,
        captured: false
      )

      black_rook.capture!(white_pawn.x_position, white_pawn.y_position)

      expect(black_rook.x_position).to eq 4
      expect(black_rook.y_position).to eq 1
    end
  end

  describe 'friendly_piece?' do
    before(:each) do
      @game = FactoryGirl.create :empty_chess_board
    end

    it 'should return true if target piece have the same color' do
      white_pawn = FactoryGirl.create(
        :pawn,
        :white,
        game_id: @game.id,
        x_position: 3,
        y_position: 0,
        captured: false
      )
      other_white_pawn = FactoryGirl.create(
        :pawn,
        :white,
        game_id: @game.id,
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
end
