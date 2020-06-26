class CreateWashTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :wash_types do |t|
      t.string :name
      t.float :cost
      t.float :price
      t.float :points

      t.timestamps
    end
  end
end
