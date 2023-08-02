class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :shop_name
      t.string :dish_name
      t.integer :price
      t.text :caption
      t.boolean :displayed, default: true

      t.timestamps
    end
  end
end
