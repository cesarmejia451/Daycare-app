class AddColumnsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :field, :text
    add_column :comments, :user_id, :integer
    add_column :comments, :post_id, :integer
  end
end
