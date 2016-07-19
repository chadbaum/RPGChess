require 'rails_helper'

RSpec.describe Queen, type: :model do
  describe 'white queen movement validation' do
    it 'should return false if the queen is not being moved from its original location' do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(4, 7)).to eq false
    end

    it 'should return false if the queen moves forward 2 spaces and then 1 space to the left' do
      knight = FactoryGirl.create(:queen, :white)
      expect(knight.valid_move?(3, 5)).to eq false
    end

    it 'should return true if the queen moves 2 spaces to the right' do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(6, 7)).to eq true
    end

    it 'should return true if the queen moves 3 spaces diagonally forward and to the right' do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(7, 4)).to eq true
    end

    it 'should return true if the queen moves forward and to the right 1 space' do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(5, 6)).to eq true
    end

    it 'should return true if the queen moves to the left 1 space' do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(3, 7)).to eq true
    end

    it 'should return true if the queen moves forward 1 space' do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(4, 6)).to eq true
    end

    it 'should return true if the queen moves forward 5 spaces' do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(4, 2)).to eq true
    end
  end

  describe 'black queen movement validation' do
    it 'should return false if the queen is not being moved from its original location' do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(4, 0)).to eq false
    end

    it 'should return false if the queen moves forward 2 spaces and then 1 space to the left' do
      knight = FactoryGirl.create(:queen, :black)
      expect(knight.valid_move?(3, 2)).to eq false
    end

    it 'should return true if the queen moves 2 spaces to the right' do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(6, 0)).to eq true
    end

    it 'should return true if the queen moves 3 spaces diagonally forward and to the right' do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(7, 3)).to eq true
    end

    it 'should return true if the queen moves forward and to the right 1 space' do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(5, 1)).to eq true
    end

    it 'should return true if the queen moves to the left 1 space' do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(3, 0)).to eq true
    end

    it 'should return true if the queen moves forward 1 space' do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(4, 1)).to eq true
    end

    it 'should return true if the queen moves forward 5 spaces' do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(4, 5)).to eq true
    end
  end

  describe 'queen creation validation' do
    it 'should have a type of Queen' do
      r = FactoryGirl.create(:queen, color: 'white')
      expect(r.type).to eq('Queen')
    end

    it 'should not be allowed to create a red queen' do
      expect { FactoryGirl.create(:queen, color: 'red') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'queen move method' do
    it "should return true and update the queen's position when it makes a valid move" do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.move!(7, 7)).to eq true
      expect(queen.x_position).to eq 7
      expect(queen.y_position).to eq 7
    end

    it "should return nil and not update the queen's position when it makes an invalid move" do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.move!(3, 7)).to eq false
      expect(queen.x_position).to eq 4
      expect(queen.y_position).to eq 0
    end
  end
end
