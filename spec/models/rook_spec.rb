require 'rails_helper'

RSpec.describe Rook, type: :model do
  let(:game) { FactoryGirl.create(:game) }
  let(:rook) do
    game.pieces.find_by(
      type: 'Rook',
      color: 'white',
      x_position: 7,
      y_position: 7
    )
  end
  let(:moved_rook) do
    game.pieces.create(
      type: 'Rook',
      color: 'white',
      x_position: 3,
      y_position: 3
    )
  end

  describe 'creation' do
    it 'should create a white rook' do
      rook = FactoryGirl.create(:rook, color: 'white')
      expect(rook.type).to eq('Rook')
    end

    it 'should fail to create a red rook' do
      expect { FactoryGirl.create(:rook, color: 'red') }.to\
        raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'moved' do
    it 'should return false if not moved' do
      expect(rook.move!(7, 7)).to eq false
      expect(rook.x_position).to eq 7
      expect(rook.y_position).to eq 7
    end
  end

  describe 'invalid moveset' do
    it 'should return false and not update position on invalid move' do
      expect(moved_rook.move!(4, 4)).to eq false
      expect(moved_rook.x_position).to eq 3
      expect(moved_rook.y_position).to eq 3
    end

    it 'should return false and not update position on invalid move' do
      expect(moved_rook.move!(5, 4)).to eq false
      expect(moved_rook.x_position).to eq 3
      expect(moved_rook.y_position).to eq 3
    end

    it 'should return false and not update position on invalid move' do
      expect(moved_rook.move!(6, 2)).to eq false
      expect(moved_rook.x_position).to eq 3
      expect(moved_rook.y_position).to eq 3
    end
  end

  describe 'non-obstructed move' do
    it 'should return true and update position on non-obstructed move' do
      expect(moved_rook.move!(7, 3)).to eq true
      expect(moved_rook.x_position).to eq 7
      expect(moved_rook.y_position).to eq 3
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_rook.move!(3, 2)).to eq true
      expect(moved_rook.x_position).to eq 3
      expect(moved_rook.y_position).to eq 2
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_rook.move!(0, 3)).to eq true
      expect(moved_rook.x_position).to eq 0
      expect(moved_rook.y_position).to eq 3
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_rook.move!(3, 5)).to eq true
      expect(moved_rook.x_position).to eq 3
      expect(moved_rook.y_position).to eq 5
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_rook.move!(2, 3)).to eq true
      expect(moved_rook.x_position).to eq 2
      expect(moved_rook.y_position).to eq 3
    end
  end

  describe 'obstructed move' do
    it 'should return false and not update position on obstructed move' do
      expect(rook.move!(7, 3)).to eq false
      expect(rook.x_position).to eq 7
      expect(rook.y_position).to eq 7
    end

    it 'should return false and not update position on obstructed move' do
      expect(rook.move!(0, 7)).to eq false
      expect(rook.x_position).to eq 7
      expect(rook.y_position).to eq 7
    end

    it 'should return false and not update position on obstructed move' do
      expect(moved_rook.move!(3, 7)).to eq false
      expect(moved_rook.x_position).to eq 3
      expect(moved_rook.y_position).to eq 3
    end

    it 'should return false and not update position on obstructed move' do
      expect(moved_rook.move!(3, 0)).to eq false
      expect(moved_rook.x_position).to eq 3
      expect(moved_rook.y_position).to eq 3
    end
  end
end
