require 'rails_helper'

RSpec.describe Queen, type: :model do
  describe 'white queen movement validation' do
    it 'should return false if not being moved' do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(4, 7)).to eq false
    end

    it 'should return false if moved 2 spaces forward and 1 space left' do
      knight = FactoryGirl.create(:queen, :white)
      expect(knight.valid_move?(3, 5)).to eq false
    end

    it 'should return true if moved 2 spaces right' do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(6, 7)).to eq true
    end

    it 'should return true if moved 3 spaces forward and 3 spaces right' do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(7, 4)).to eq true
    end

    it 'should return true if moved forward and 1 space right' do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(5, 6)).to eq true
    end

    it 'should return true if moved 1 space left' do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(3, 7)).to eq true
    end

    it 'should return true if moved 1 space forward' do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(4, 6)).to eq true
    end

    it 'should return true if the queen moves forward 5 spaces' do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(4, 2)).to eq true
    end
  end

  describe 'black queen movement validation' do
    it 'should return false if not being moved' do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(4, 0)).to eq false
    end

    it 'should return false if moved 2 spaces forward and 1 space left' do
      knight = FactoryGirl.create(:queen, :black)
      expect(knight.valid_move?(3, 2)).to eq false
    end

    it 'should return true if moved 2 spaces right' do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(6, 0)).to eq true
    end

    it 'should return true if moved 3 spaces forward and 3 spaces right' do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(7, 3)).to eq true
    end

    it 'should return true if moved 1 space forward and 1 space right' do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(5, 1)).to eq true
    end

    it 'should return true if moved 1 space left' do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(3, 0)).to eq true
    end

    it 'should return true if moved forward 1 space' do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(4, 1)).to eq true
    end

    it 'should return true if nmoved forward 5 spaces' do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(4, 5)).to eq true
    end
  end

  describe 'queen creation validation' do
    it 'should create a white queen' do
      r = FactoryGirl.create(:queen, color: 'white')
      expect(r.type).to eq('Queen')
    end

    it 'should fail to create a red queen' do
      expect { FactoryGirl.create(:queen, color: 'red') }.to
      raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'queen move method' do
    it 'should return true and update position on valid move' do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.move!(7, 7)).to eq true
      expect(queen.x_position).to eq 7
      expect(queen.y_position).to eq 7
    end

    it 'should return nil and not update position on invalid move' do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.move!(3, 7)).to eq false
      expect(queen.x_position).to eq 4
      expect(queen.y_position).to eq 0
    end
  end
end
