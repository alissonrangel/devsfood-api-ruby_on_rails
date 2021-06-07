class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      
      t.string :name, null: false
      t.string :image, null: false
      t.string :ingredients
      t.integer :category_id, null: false
      t.float :price, null: false
      t.integer :points

      t.timestamps
    end
  end
end
