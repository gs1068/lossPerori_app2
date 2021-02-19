class AddColumnToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :categories, :string
  end
end
