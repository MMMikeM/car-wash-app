class CreateWashes < ActiveRecord::Migration[6.0]
  def change
    create_table :washes, id: :uuid do |t|
      t.references :wash_type, type: :uuid, null: false, foreign_key: true
      t.references :user, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
