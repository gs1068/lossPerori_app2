class AddProductAvatarToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :product_avatars, :string
  end
end
