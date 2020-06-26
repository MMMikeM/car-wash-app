class AddCurrentPointsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :current_points, :float, default: 0
  end
end
