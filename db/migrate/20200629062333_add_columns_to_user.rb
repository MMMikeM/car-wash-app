class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :contact_number, :string
    add_column :users, :total_points, :integer, default: 0
  end
end
