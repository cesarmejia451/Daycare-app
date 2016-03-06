class AddUserIdAndCenterIdToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :user_id, :integer
    add_column :referrals, :center_id, :integer
  end
end
