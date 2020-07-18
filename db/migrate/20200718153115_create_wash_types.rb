class CreateWashTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :wash_types, id: :uuid do |t|
      t.string :name
      t.bigint :cost
      t.bigint :price
      t.integer :points

      t.timestamps
    end
  end
end
