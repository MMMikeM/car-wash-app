class AddBranchIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :branch, type: :uuid
    add_reference :wash_types, :branch, type: :uuid
  end
end
