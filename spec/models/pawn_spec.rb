require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe "pawn movement validation" do

    it "should return false if the pawn is not being moved from its original location" do
      pawn = FactoryGirl.create(:pawn)
      expect(pawn.valid_move?(6,5)).to eq false
    end

    it "should return false if the pawn is moved 3 spaces to the left" do
      pawn = FactoryGirl.create(:pawn)
      expect(pawn.valid_move?(6,2)).to eq false
    end

    it "should return false if the pawn is moved backwards" do
      pawn = FactoryGirl.create(:pawn)
      expect(pawn.valid_move?(7,5)).to eq false
    end

    it "should return false if the pawn is moved two spaces but not on its first move" do
      pawn = FactoryGirl.create(:pawn, :moved)
      expect(pawn.valid_move?(3,5)).to eq false
    end

    it "should return true if the pawn is moved two spaces forward on its first move" do
      pawn = FactoryGirl.create(:pawn)
      expect(pawn.valid_move?(4,5)).to eq true
    end

    it "should return true if the pawn is moved one space forward" do
      pawn = FactoryGirl.create(:pawn)
      expect(pawn.valid_move?(5,5)).to eq true
    end

  end
end
