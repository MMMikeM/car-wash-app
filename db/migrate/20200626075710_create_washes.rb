class CreateWashes < ActiveRecord::Migration[6.0]
  def change
    create_table :washes do |t|
      t.boolean :free, null: false
      t.references :wash_type, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
