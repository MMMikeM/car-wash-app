class AddFieldsToRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :wash_types, :free, :boolean, default: false
    add_column :washes, :hidden, :boolean, default: false
    add_column :users, :hidden, :boolean, default: false
    add_column :vehicles, :hidden, :boolean, default: false
  end
end
