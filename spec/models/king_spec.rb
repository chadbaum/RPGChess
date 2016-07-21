require 'rails_helper'

RSpec.describe King, type: :model do
  describe 'white king movement validation' do
    king = FactoryGirl.create(:king, :white)

    it 'should return false if not moved' do
      expect(king.valid_move?(3, 7)).to eq false
    end

    it 'should return false if moved 2 spaces right' do
      expect(king.valid_move?(5, 7)).to eq false
    end

    it 'should return false if moved 3 spaces forward and 3 spaces right' do
      expect(king.valid_move?(6, 4)).to eq false
    end

    it 'should return true if moved 1 space forward and 1 space right' do
      expect(king.valid_move?(4, 6)).to eq true
    end

    it 'should return true if moved to 1 space left' do
      expect(king.valid_move?(2, 7)).to eq true
    end

    it 'should return true if moved 1 space forward' do
      expect(king.valid_move?(3, 6)).to eq true
    end
  end

  describe 'black king movement validation' do
    king = FactoryGirl.create(:king, :black)

    it 'should return false if not moved' do
      expect(king.valid_move?(3, 0)).to eq false
    end

    it 'should return false if moved 2 spaces right' do
      expect(king.valid_move?(5, 0)).to eq false
    end

    it 'should return false if moved 3 spaces forward and 3 spaces right' do
      expect(king.valid_move?(6, 3)).to eq false
    end

    it 'should return true if moved 1 space forward and 1 space right' do
      expect(king.valid_move?(4, 1)).to eq true
    end

    it 'should return true if moved 1 space left' do
      expect(king.valid_move?(2, 0)).to eq true
    end

    it 'should return true if moved 1 space forward' do
      expect(king.valid_move?(3, 1)).to eq true
    end
  end

  describe 'king creation validation' do
    it 'should create a white king' do
      king = FactoryGirl.create(:king, color: 'white')
      expect(king.type).to eq('King')
    end

    it 'should fail to create a red king' do
      expect { FactoryGirl.create(:king, color: 'red') }.to\
        raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'king move method' do
    it 'should return true and update position on valid move' do
      king = FactoryGirl.create(:king, :white)
      expect(king.move!(4, 6)).to eq true
      expect(king.x_position).to eq 4
      expect(king.y_position).to eq 6
    end

    it 'should return nil and not update position on invalid move' do
      king = FactoryGirl.create(:king, :black)
      expect(king.move!(5, 0)).to eq false
      expect(king.x_position).to eq 3
      expect(king.y_position).to eq 0
    end
  end
end
