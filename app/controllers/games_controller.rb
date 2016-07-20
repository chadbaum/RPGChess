# Main controller for chess session for CRUD
# logic for our app
class GamesController < ApplicationController

  def create
    @game = Game.new
  end


  def index

  end
  

  def new
  end
end
