require 'rails_helper'

RSpec.describe Knight, type: :model do
  describe 'white knight movement validation' do
    let(:knight) { FactoryGirl.create(:knight, :white) }

    it 'should return false if not moved' do
      expect(knight.valid_move?(1, 7)).to eq false
    end

    it 'should return false if moved 2 spaces right' do
      expect(knight.valid_move?(3, 7)).to eq false
    end

    it 'should return false if moved 1 space forward' do
      expect(knight.valid_move?(1, 6)).to eq false
    end

    it 'should return false if moved 3 spaces forward and 3 spaces right' do
      expect(knight.valid_move?(4, 4)).to eq false
    end

    it 'should return true if moved 2 spaces forward and 1 space left' do
      expect(knight.valid_move?(2, 5)).to eq true
    end

    it 'should return true if moved to 2 spaces right and 1 space forward' do
      expect(knight.valid_move?(3, 6)).to eq true
    end
  end

  describe 'black knight movement validation' do
    let(:knight) { FactoryGirl.create(:knight, :black) }

    it 'should return false if not moved' do
      expect(knight.valid_move?(1, 0)).to eq false
    end

    it 'should return false if moved 2 spaces right' do
      expect(knight.valid_move?(3, 0)).to eq false
    end

    it 'should return false if moved 1 space forward' do
      expect(knight.valid_move?(1, 1)).to eq false
    end

    it 'should return false if moved 3 spaces forward and 3 spaces right' do
      expect(knight.valid_move?(4, 3)).to eq false
    end

    it 'should return true if moved 2 spaces forward and 1 space left' do
      expect(knight.valid_move?(0, 2)).to eq true
    end

    it 'should return true if moved to 2 spaces right and 1 space forward' do
      expect(knight.valid_move?(3, 1)).to eq true
    end
  end

  describe 'knight creation validation' do
    it 'should create a white knight' do
      knight = FactoryGirl.create(:knight, color: 'white')
      expect(knight.type).to eq('Knight')
    end

    it 'should fail to create a red knight' do
      expect { FactoryGirl.create(:knight, color: 'red') }.to\
        raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'knight move method' do
    it 'should return true and update position on valid move' do
      knight = FactoryGirl.create(:knight, :white)
      expect(knight.move!(3, 6)).to eq true
      expect(knight.x_position).to eq 3
      expect(knight.y_position).to eq 6
    end

    it 'should return nil and not update position on invalid move' do
      knight = FactoryGirl.create(:knight, :black)
      expect(knight.move!(3, 0)).to eq false
      expect(knight.x_position).to eq 1
      expect(knight.y_position).to eq 0
    end
  end
end
