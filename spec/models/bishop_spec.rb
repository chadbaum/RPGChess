require 'rails_helper'

RSpec.describe Bishop, type: :model do
  describe 'white bishop movement validation' do
    it 'should return false if not moved' do
      bishop = FactoryGirl.create(:bishop, :white)
      expect(bishop.valid_move?(2, 7)).to eq false
    end

    it 'should return false if moved 2 spaces left' do
      bishop = FactoryGirl.create(:bishop, :white)
      expect(bishop.valid_move?(0, 7)).to eq false
    end

    it 'should return false if moved 1 space forward' do
      bishop = FactoryGirl.create(:bishop, :white)
      expect(bishop.valid_move?(2, 6)).to eq false
    end

    it 'should return true if moved 3 spaces forward and 3 spaces right' do
      bishop = FactoryGirl.create(:bishop, :white)
      expect(bishop.valid_move?(5, 4)).to eq true
    end

    it 'should return true if moved 2 spaces forward and 2 spaces left' do
      bishop = FactoryGirl.create(:bishop, :white)
      expect(bishop.valid_move?(0, 5)).to eq true
    end
  end

  describe 'black bishop movement validation' do
    it 'should return false if not moved' do
      bishop = FactoryGirl.create(:bishop, :black)
      expect(bishop.valid_move?(2, 0)).to eq false
    end

    it 'should return false if moved 2 spaces right' do
      bishop = FactoryGirl.create(:bishop, :black)
      expect(bishop.valid_move?(4, 0)).to eq false
    end

    it 'should return false if moved 1 space forward' do
      bishop = FactoryGirl.create(:bishop, :black)
      expect(bishop.valid_move?(2, 1)).to eq false
    end

    it 'should return true if moved 3 spaces forward and spaces right' do
      bishop = FactoryGirl.create(:bishop, :black)
      expect(bishop.valid_move?(5, 3)).to eq true
    end

    it 'should return true if moved 2 spaces forward and 2 spaces left' do
      bishop = FactoryGirl.create(:bishop, :black)
      expect(bishop.valid_move?(0, 2)).to eq true
    end
  end

  describe 'bishop creation validation' do
    it 'should create a white bishop' do
      r = FactoryGirl.create(:bishop, color: 'white')
      expect(r.type).to eq('Bishop')
    end

    it 'should fail to create a red bishop' do
      expect { FactoryGirl.create(:bishop, color: 'red') }.to\
        raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'bishop move method' do
    it 'should return true and update position on valid move' do
      bishop = FactoryGirl.create(:bishop, :white)
      expect(bishop.move!(3, 6)).to eq true
      expect(bishop.x_position).to eq 3
      expect(bishop.y_position).to eq 6
    end

    it 'should return nil and not update position on invalid move' do
      bishop = FactoryGirl.create(:bishop, :black)
      expect(bishop.move!(3, 0)).to eq false
      expect(bishop.x_position).to eq 2
      expect(bishop.y_position).to eq 0
    end
  end

  describe 'obstructed logic' do
    game = FactoryGirl.create(:game)
    bishop = game.pieces.find_by(type: 'Bishop', color: 'white', x_position: 2, y_position: 7)
    moved_bishop = game.pieces.create(type: 'Bishop', color: 'white', x_position: 3, y_position: 3)

    it 'should return false and not update position on obstructed move' do
      expect(bishop.move!(4, 5)).to eq false
      expect(bishop.x_position).to eq 2
      expect(bishop.y_position).to eq 7
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_bishop.move!(5, 5)).to eq true
      expect(moved_bishop.x_position).to eq 5
      expect(moved_bishop.y_position).to eq 5
    end
  end
end
