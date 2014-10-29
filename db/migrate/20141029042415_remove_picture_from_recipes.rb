class RemovePictureFromRecipes < ActiveRecord::Migration
  def change
    remove_column :recipes, :picture, :string
  end
end
