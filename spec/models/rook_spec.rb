require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe "white rook movement validation" do

    it "should return false if the rook is not being moved from its original location" do
      rook = FactoryGirl.create(:rook)
      expect(rook.valid_move?(7,7)).to eq false
    end

    it "should return false if the rook is moved 3 spaces diagonally" do
      rook = FactoryGirl.create(:rook)
      expect(rook.valid_move?(4,4)).to eq false
    end

    it "should return true if the rook is moved forward 3 spaces" do
      rook = FactoryGirl.create(:rook)
      expect(rook.valid_move?(4,7)).to eq true
    end

    it "should return true if the rook is moved three spaces to the left" do
      rook = FactoryGirl.create(:rook)
      expect(rook.valid_move?(7,4)).to eq true
    end

  end
end
