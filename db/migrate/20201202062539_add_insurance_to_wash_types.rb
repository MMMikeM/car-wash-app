class AddInsuranceToWashTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :wash_types, :insurance, :boolean, default: false
  end
end
