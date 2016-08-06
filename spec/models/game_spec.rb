require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'populate the board' do
    let(:game) { FactoryGirl.create(:game, :populated) }

    it 'should give us 32 pieces upon board population' do
      expect(game.pieces.count).to eq 32
    end
    it 'should give me the last x position of population' do
      expect(game.pieces.last.x_position).to eq 7
    end
    it 'should give me the last y position of population' do
      expect(game.pieces.last.y_position).to eq 7
    end
    it 'should give me the last piece of the population as the King' do
      expect(game.pieces.last.type).to eq 'Rook'
    end
    it 'should give me the last pieces color' do
      expect(game.pieces.last.color).to eq 'white'
    end
  end

  describe 'check?' do
    let(:empty_game) { FactoryGirl.create(:game) }
    let(:blk_king) do
      empty_game.pieces.create(
        type: 'King',
        color: 'black',
        x_position: 3,
        y_position: 4,
        moved: true
      )
    end
    let(:queen) do
      empty_game.pieces.create(
        type: 'Queen',
        color: 'white',
        x_position: 1,
        y_position: 5,
        moved: true
      )
    end
    let(:knight) do
      empty_game.pieces.create(
        type: 'Knight',
        color: 'white',
        x_position: 6,
        y_position: 7,
        moved: false
      )
    end

    it 'should return true if King is under check horizontally' do
      expect(queen.move!(1, 4)).to eq true
      expect(blk_king.x_position).to eq 3
      expect(blk_king.y_position).to eq 4
      expect(empty_game.black_check?).to eq true
    end
    it 'should return true if King is under check vertically' do
      expect(queen.move!(3, 7)).to eq true
      expect(blk_king.x_position).to eq 3
      expect(blk_king.y_position).to eq 4
      expect(empty_game.black_check?).to eq true
    end
    it 'should return true if King is under check diagonally' do
      expect(queen.move!(1, 2)).to eq true
      expect(blk_king.x_position).to eq 3
      expect(blk_king.y_position).to eq 4
      expect(empty_game.black_check?).to eq true
    end
    it 'should return true if King is under check in L-shape move' do
      expect(knight.move!(5, 5)).to eq true
      expect(blk_king.x_position).to eq 3
      expect(blk_king.y_position).to eq 4
      expect(empty_game.black_check?).to eq true
    end
    it 'should return false if King is not under check' do
      expect(queen.move!(1, 3)).to eq true
      expect(blk_king.x_position).to eq 3
      expect(blk_king.y_position).to eq 4
      expect(empty_game.black_check?).to eq false
    end
    it 'should return false if King is not under check in L-shape move' do
      expect(knight.move!(7, 5)).to eq true
      expect(blk_king.x_position).to eq 3
      expect(blk_king.y_position).to eq 4
      expect(empty_game.black_check?).to eq false
    end
  end
end
