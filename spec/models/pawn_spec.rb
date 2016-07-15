require 'rails_helper'

RSpec.describe Pawn, type: :model do

  describe "white pawn movement validation" do

    it "should return false if the pawn is not being moved from its original location" do
      pawn = FactoryGirl.create(:pawn, :white)
      expect(pawn.valid_move?(5,6)).to eq false
    end

    it "should return false if the pawn is moved 3 spaces to the left" do
      pawn = FactoryGirl.create(:pawn, :white)
      expect(pawn.valid_move?(2,6)).to eq false
    end

    it "should return false if the pawn is moved backwards" do
      pawn = FactoryGirl.create(:pawn, :white)
      expect(pawn.valid_move?(5,7)).to eq false
    end

    it "should return true if the pawn is moved one space forward" do
      pawn = FactoryGirl.create(:pawn, :white, :moved)
      expect(pawn.valid_move?(5,4)).to eq true
    end

    it "should return false if the pawn is moved two spaces but not on its first move" do
      pawn = FactoryGirl.create(:pawn, :white, :moved)
      expect(pawn.valid_move?(5,3)).to eq false
    end

    it "should return true if the pawn is moved two spaces forward on its first move" do
      pawn = FactoryGirl.create(:pawn, :white)
      expect(pawn.valid_move?(5,4)).to eq true
    end

    it "should return true if the pawn is moved one space forward on its first move" do
      pawn = FactoryGirl.create(:pawn, :white)
      expect(pawn.valid_move?(5,5)).to eq true
    end

  end

  describe "black pawn movement validation" do

    it "should return false if the pawn is not being moved from its original location" do
      pawn = FactoryGirl.create(:pawn, :black)
      expect(pawn.valid_move?(5,1)).to eq false
    end

    it "should return false if the pawn is moved 3 spaces to the left" do
      pawn = FactoryGirl.create(:pawn, :black)
      expect(pawn.valid_move?(2,1)).to eq false
    end

    it "should return false if the pawn is moved backwards" do
      pawn = FactoryGirl.create(:pawn, :black)
      expect(pawn.valid_move?(5,0)).to eq false
    end

    it "should return true if the pawn is moved one space forward" do
      pawn = FactoryGirl.create(:pawn, :black, :moved)
      expect(pawn.valid_move?(5,6)).to eq true
    end

    it "should return false if the pawn is moved two spaces but not on its first move" do
      pawn = FactoryGirl.create(:pawn, :black, :moved)
      expect(pawn.valid_move?(5,5)).to eq false
    end

    it "should return true if the pawn is moved two spaces forward on its first move" do
      pawn = FactoryGirl.create(:pawn, :black)
      expect(pawn.valid_move?(5,3)).to eq true
    end

    it "should return true if the pawn is moved one space forward on its first move" do
      pawn = FactoryGirl.create(:pawn, :black)
      expect(pawn.valid_move?(5,2)).to eq true
    end
  end

  describe "Pawn creation validation" do

    it "should have a type of Pawn" do
      r = FactoryGirl.create(:pawn, color: 'white')
      expect(r.type).to eq("Pawn")
    end

    it "should not be allowed to create a red pawn" do
      expect { FactoryGirl.create(:pawn, color: "red") }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

end
