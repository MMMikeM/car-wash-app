class CreateWashes < ActiveRecord::Migration[6.0]
  def change
    create_table :washes, id: :uuid do |t|
      t.boolean :free, null: false
      t.references :wash_type, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
