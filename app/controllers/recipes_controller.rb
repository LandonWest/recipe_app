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
      flash[:notice] = 'Recipe Created Successfully!'
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

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      flash[:notice] = 'Recipe Updated Successfuly!'
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:user_id, :name, :description, :picture, :directions, :recipe_pic)
  end
end
