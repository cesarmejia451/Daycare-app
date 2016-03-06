class ChangeHoursInCentersToText < ActiveRecord::Migration
  def change
    change_column :centers, :hours, :text
  end
end
