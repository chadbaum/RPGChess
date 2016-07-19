require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe 'white rook movement validation' do
    it 'should return false if not being moved' do
      rook = FactoryGirl.create(:rook, :white)
      expect(rook.valid_move?(7, 7)).to eq false
    end

    it 'should return false if moved 3 spaces diagonally' do
      rook = FactoryGirl.create(:rook, :white)
      expect(rook.valid_move?(4, 4)).to eq false
    end

    it 'should return true if moved 3 spaces forward' do
      rook = FactoryGirl.create(:rook, :white)
      expect(rook.valid_move?(7, 4)).to eq true
    end

    it 'should return true if moved 3 spaces left' do
      rook = FactoryGirl.create(:rook, :white)
      expect(rook.valid_move?(4, 7)).to eq true
    end
  end

  describe 'black rook movement validation' do
    it 'should return false if not being moved' do
      rook = FactoryGirl.create(:rook, :black)
      expect(rook.valid_move?(0, 0)).to eq false
    end

    it 'should return false if moved 3 spaces forward and 3 spaces right' do
      rook = FactoryGirl.create(:rook, :black)
      expect(rook.valid_move?(3, 3)).to eq false
    end

    it 'should return true if moved 3 spaces forward' do
      rook = FactoryGirl.create(:rook, :black)
      expect(rook.valid_move?(0, 3)).to eq true
    end

    it 'should return true if moved 3 spaces right' do
      rook = FactoryGirl.create(:rook, :black)
      expect(rook.valid_move?(3, 0)).to eq true
    end
  end

  describe 'rook creation validation' do
    it 'should create a white rook' do
      rook = FactoryGirl.create(:rook, color: 'white')
      expect(rook.type).to eq('Rook')
    end

    it 'should fail to create a red rook' do
      expect { FactoryGirl.create(:rook, color: 'red') }.to
      raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'rook move method' do
    it 'should return true and update position on valid move' do
      rook = FactoryGirl.create(:rook, :white)
      expect(rook.move!(0, 7)).to eq true
      expect(rook.x_position).to eq 0
      expect(rook.y_position).to eq 7
    end

    it 'should return nil and not update position on invalid move' do
      rook = FactoryGirl.create(:rook, :black)
      expect(rook.move!(3, 7)).to eq false
      expect(rook.x_position).to eq 0
      expect(rook.y_position).to eq 0
    end
  end
end
