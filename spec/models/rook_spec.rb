require 'rails_helper'

RSpec.describe Rook, type: :model do
    describe "Rook" do
    it "should have a type of Rook" do
      r = FactoryGirl.create(:rook)
      expect(r.type).to eq("Rook")
    end

    it "should not be allowed to create a red rook" do
      expect { FactoryGirl.create(:rook, color: "red") }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
