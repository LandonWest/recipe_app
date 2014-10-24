class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]

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
    @user = User.find(@recipe.user_id)
    @ingredients = @recipe.ingredients
  end

  def edit
    @user = User.find(@recipe.user_id)
  end

  def update
    if @recipe.update_attributes(recipe_params)
      flash[:notice] = 'Recipe Updated Successfuly!'
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    flash[:notice] = 'Recipe Deleted Successfully!'
    redirect_to user_path(current_user)
  end


  private

  def find_recipe
    @recipe = Recipe.includes(:ingredients).find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:user_id, :name, :description, :picture, :directions, :recipe_pic, ingredients_attributes: [:name, :quantity, :unit_of_measurement, :id, :_destroy] )
  end
end
