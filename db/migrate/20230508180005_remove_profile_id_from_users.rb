class RemoveProfileIdFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :profile_id, :string
  end
end
