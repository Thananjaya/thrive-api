class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.float :gross_amount, precision: 7, scale: 2
      t.references :user, index: true

      t.timestamps
    end
  end
end
