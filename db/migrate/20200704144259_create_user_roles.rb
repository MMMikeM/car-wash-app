class CreateUserRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_roles, id: :uuid do |t|
      t.references :role, type: :uuid, null: false, foreign_key: true
      t.references :user, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_roles, %i[user_id role_id],  name: "index_unique_user_roles"
  end
end
