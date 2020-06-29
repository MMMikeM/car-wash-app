class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles, id: :uuid do |t|
      t.string :registration_number, unique: true
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
