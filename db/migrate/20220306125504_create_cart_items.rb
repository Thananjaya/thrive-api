class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.references :cart
      t.string :item_id
      t.integer :quantity
      t.string :integer
      t.integer :addon_id
      t.float :addon_price
      t.integer :variation_id
      t.float :variation_price
      t.float :total_price
      t.float :base_price

      t.timestamps
    end
  end
end
