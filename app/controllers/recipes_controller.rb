class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = User.find(@recipe.user_id)
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @user = User.find(@recipe.user_id)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:user_id, :name, :description, :picture, :directions, :recipe_pic)
  end
end
