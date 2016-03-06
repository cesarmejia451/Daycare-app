class AddFieldToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :description, :text
  end
end
