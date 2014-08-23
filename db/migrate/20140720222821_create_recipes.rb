class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.belongs_to :user
      t.integer :user_id, null: false
      t.string :name, null: false
      t.text :description
      t.string :picture
      t.text :directions, null: false
      t.timestamps
    end
  end
end
