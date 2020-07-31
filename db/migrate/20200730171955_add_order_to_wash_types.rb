class AddOrderToWashTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :wash_types, :order, :integer, default: 0
  end
end
