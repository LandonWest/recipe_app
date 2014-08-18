class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:user_id, :name, :description, :picture, :directions)
  end
end
