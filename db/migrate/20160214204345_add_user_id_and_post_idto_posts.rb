class AddUserIdAndPostIdtoPosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer
    add_column :posts, :center_id, :integer
  end
end
