class AddHiddenToWashType < ActiveRecord::Migration[6.0]
  def change
    add_column :wash_types, :hidden, :boolean, default: false
  end
end
