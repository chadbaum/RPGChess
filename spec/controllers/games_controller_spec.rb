require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'games#index' do
    it 'should successfully load the homepage' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'games#new' do
    it 'should show the new form if the user is signed in' do
      user = FactoryGirl.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end
  describe 'games#create' do
    it 'should create a new game in the database' do
      post :create, game: { turn: nil }
    end
  end
end
