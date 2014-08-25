class AddRecipePicToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :recipe_pic, :string
  end
end
