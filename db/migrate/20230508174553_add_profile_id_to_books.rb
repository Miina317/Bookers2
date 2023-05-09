class AddProfileIdToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :profile_id, :integer
  end
end
