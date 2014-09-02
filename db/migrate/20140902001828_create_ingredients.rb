class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.belongs_to :recipe
      t.integer :recipe_id, null:false
      t.string :name, null:false
      t.string :quantity, null:false
      t.string :units, null:false

      t.timestamps
    end
  end
end
