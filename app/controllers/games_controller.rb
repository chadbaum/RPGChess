# Main controller for chess session for CRUD
# logic for our app
class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def index
  end

  def create
    @game = Game.new
  end

  def show
    @game = Game.new
  end
end
