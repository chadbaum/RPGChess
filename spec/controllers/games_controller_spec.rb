require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "games#index" do
    it "should successfully load the homepage" do
      get :index
      expect(response).to have_http_request(:success)
    end
  end
end
