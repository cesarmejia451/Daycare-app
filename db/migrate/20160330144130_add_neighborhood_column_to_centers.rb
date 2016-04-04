class AddNeighborhoodColumnToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :neighborhood, :text
  end
end
