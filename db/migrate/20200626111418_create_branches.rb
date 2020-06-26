class CreateBranches < ActiveRecord::Migration[6.0]
  def change
    create_table :branches, id: :uuid do |t|
      t.string :name, null: false
      t.float :free_wash_points, null: false

      t.timestamps
    end
  end
end
