require 'rails_helper'

RSpec.describe Queen, type: :model do
    describe "Queen" do
    it "should have a type of Queen" do
      r = FactoryGirl.create(:queen)
      expect(r.type).to eq("Queen")
    end

    it "should not be allowed to create a red queen" do
      expect { FactoryGirl.create(:queen, color: "red") }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
