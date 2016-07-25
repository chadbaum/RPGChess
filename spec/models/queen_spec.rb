require 'rails_helper'

RSpec.describe Queen, type: :model do
  let(:game) { FactoryGirl.create(:game) }
  let(:queen) do
    game.pieces.find_by(
      type: 'Queen',
      color: 'white',
      x_position: 3,
      y_position: 7
    )
  end
  let(:moved_queen) do
    game.pieces.create(
      type: 'Queen',
      color: 'white',
      x_position: 3,
      y_position: 3
    )
  end

  describe 'creation' do
    it 'should create a white queen' do
      queen = FactoryGirl.create(:queen, color: 'white')
      expect(queen.type).to eq('Queen')
    end

    it 'should fail to create a red queen' do
      expect { FactoryGirl.create(:queen, color: 'red') }.to\
        raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'moved' do
    it 'should return false if not moved' do
      expect(queen.move!(3, 7)).to eq false
      expect(queen.x_position).to eq 3
      expect(queen.y_position).to eq 7
    end
  end

  describe 'invalid moveset' do
    it 'should return false and not update position on invalid move' do
      expect(moved_queen.move!(4, 5)).to eq false
      expect(moved_queen.x_position).to eq 3
      expect(moved_queen.y_position).to eq 3
    end

    it 'should return false and not update position on invalid move' do
      expect(moved_queen.move!(7, 4)).to eq false
      expect(moved_queen.x_position).to eq 3
      expect(moved_queen.y_position).to eq 3
    end

    it 'should return false and not update position on invalid move' do
      expect(moved_queen.move!(1, 2)).to eq false
      expect(moved_queen.x_position).to eq 3
      expect(moved_queen.y_position).to eq 3
    end
  end

  describe 'non-obstructed move' do
    it 'should return true and update position on non-obstructed move' do
      expect(moved_queen.move!(7, 3)).to eq true
      expect(moved_queen.x_position).to eq 7
      expect(moved_queen.y_position).to eq 3
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_queen.move!(3, 2)).to eq true
      expect(moved_queen.x_position).to eq 3
      expect(moved_queen.y_position).to eq 2
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_queen.move!(5, 5)).to eq true
      expect(moved_queen.x_position).to eq 5
      expect(moved_queen.y_position).to eq 5
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_queen.move!(4, 2)).to eq true
      expect(moved_queen.x_position).to eq 4
      expect(moved_queen.y_position).to eq 2
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_queen.move!(0, 3)).to eq true
      expect(moved_queen.x_position).to eq 0
      expect(moved_queen.y_position).to eq 3
    end
  end

  describe 'obstructed move' do
    it 'should return false and not update position on obstructed move' do
      expect(queen.move!(3, 0)).to eq false
      expect(queen.x_position).to eq 3
      expect(queen.y_position).to eq 7
    end

    it 'should return false and not update position on obstructed move' do
      expect(queen.move!(7, 7)).to eq false
      expect(queen.x_position).to eq 3
      expect(queen.y_position).to eq 7
    end

    it 'should return false and not update position on obstructed move' do
      expect(moved_queen.move!(0, 0)).to eq false
      expect(moved_queen.x_position).to eq 3
      expect(moved_queen.y_position).to eq 3
    end
  end
end
