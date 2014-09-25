class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.belongs_to :recipe
      t.string :name
      t.string :quantity
      t.string :unit_of_measurement
      t.timestamps
    end

    add_index :ingredients, :recipe_id
  end
end
