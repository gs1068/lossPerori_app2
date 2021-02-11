class ChangeDataTotalWeightToProduct < ActiveRecord::Migration[6.1]
  def change
    change_column :products, :total_weight, :float
  end
end
