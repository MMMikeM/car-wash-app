class AddLoyaltyEnabledToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :loyalty_enabled, :boolean, default: true
  end
end
