require 'rails_helper'

RSpec.describe Knight, type: :model do
    describe "Knight" do
    it "should have a type of Knight" do
      r = FactoryGirl.create(:knight)
      expect(r.type).to eq("Knight")
    end

    it "should not be allowed to create a red knight" do
      expect { FactoryGirl.create(:knight, color: "red") }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
