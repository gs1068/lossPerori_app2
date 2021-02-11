class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.text :product_intro
      t.text :raw_material
      t.integer :fee
      t.datetime :expiration_date
      t.integer :total_weight
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :products, [:user_id, :created_at]
  end
end
