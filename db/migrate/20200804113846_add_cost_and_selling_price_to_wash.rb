class AddCostAndSellingPriceToWash < ActiveRecord::Migration[6.0]
  def change
    add_column :washes, :cost, :bigint, default: 0
    add_column :washes, :price, :bigint, default: 0
  end
end
