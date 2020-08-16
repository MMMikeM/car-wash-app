class AddOptedForMarketingToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :opted_for_marketing, :boolean, default: false
  end
end
