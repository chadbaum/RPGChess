require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'white pawn movement validation' do
    it 'should return false if not moved' do
      pawn = FactoryGirl.create(:pawn, :white)
      expect(pawn.valid_move?(5, 6)).to eq false
    end

    it 'should return false if moved 3 spaces left' do
      pawn = FactoryGirl.create(:pawn, :white)
      expect(pawn.valid_move?(2, 6)).to eq false
    end

    it 'should return false if moved 1 space backward' do
      pawn = FactoryGirl.create(:pawn, :white)
      expect(pawn.valid_move?(5, 7)).to eq false
    end

    it 'should return true if moved 1 space forward' do
      pawn = FactoryGirl.create(:pawn, :white, :moved)
      expect(pawn.valid_move?(5, 4)).to eq true
    end

    it 'should return false if moved 2 spaces not on first move' do
      pawn = FactoryGirl.create(:pawn, :white, :moved)
      expect(pawn.valid_move?(5, 3)).to eq false
    end

    it 'should return true if moved 2 spaces forward on first move' do
      pawn = FactoryGirl.create(:pawn, :white)
      expect(pawn.valid_move?(5, 4)).to eq true
    end

    it 'should return true if moved 1 space forward on first move' do
      pawn = FactoryGirl.create(:pawn, :white)
      expect(pawn.valid_move?(5, 5)).to eq true
    end
  end

  describe 'black pawn movement validation' do
    it 'should return false if not moved' do
      pawn = FactoryGirl.create(:pawn, :black)
      expect(pawn.valid_move?(5, 1)).to eq false
    end

    it 'should return false if moved 3 spaces left' do
      pawn = FactoryGirl.create(:pawn, :black)
      expect(pawn.valid_move?(2, 1)).to eq false
    end

    it 'should return false if moved 1 space backward' do
      pawn = FactoryGirl.create(:pawn, :black)
      expect(pawn.valid_move?(5, 0)).to eq false
    end

    it 'should return true if moved 1 space forward' do
      pawn = FactoryGirl.create(:pawn, :black, :moved)
      expect(pawn.valid_move?(5, 6)).to eq true
    end

    it 'should return false if moved 2 spaces forward not on first move' do
      pawn = FactoryGirl.create(:pawn, :black, :moved)
      expect(pawn.valid_move?(5, 5)).to eq false
    end

    it 'should return true if moved 2 spaces forward on first move' do
      pawn = FactoryGirl.create(:pawn, :black)
      expect(pawn.valid_move?(5, 3)).to eq true
    end

    it 'should return true if moved 1 space forward on first move' do
      pawn = FactoryGirl.create(:pawn, :black)
      expect(pawn.valid_move?(5, 2)).to eq true
    end
  end

  describe 'pawn creation validation' do
    it 'should create a white pawn' do
      r = FactoryGirl.create(:pawn, color: 'white')
      expect(r.type).to eq('Pawn')
    end

    it 'should fail to create a red pawn' do
      expect { FactoryGirl.create(:pawn, color: 'red') }.to
      raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'pawn move method' do
    it 'should return true and update position on valid move' do
      pawn = FactoryGirl.create(:pawn, :white)
      expect(pawn.move!(5, 5)).to eq true
      expect(pawn.x_position).to eq 5
      expect(pawn.y_position).to eq 5
    end

    it 'should return nil and not update position on invalid move' do
      pawn = FactoryGirl.create(:pawn, :black)
      expect(pawn.move!(5, 0)).to eq false
      expect(pawn.x_position).to eq 5
      expect(pawn.y_position).to eq 1
    end
  end
end
