class ChangeDataProductAvatarsToProducts < ActiveRecord::Migration[6.1]
  def change
    change_column :products, :product_avatars, :json
  end
end
