class AddDescriptionToWashTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :wash_types, :description, :string
  end
end
