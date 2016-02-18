class RemoveNeighborhodFromCenters < ActiveRecord::Migration
  def change
    remove_column :centers, :neighborhod, :string
  end
end
