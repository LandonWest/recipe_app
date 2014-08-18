class UserController < ApplicationController

  def show
    @user = User.find(params[:id])
    @recipes = Recipe.all
  end

end
