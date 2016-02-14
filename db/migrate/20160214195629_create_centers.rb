class CreateCenters < ActiveRecord::Migration
  def change
    create_table :centers do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :website
      t.string :neighborhod
      t.string :zip_code
      t.string :phone
      t.text :description
      t.string :hours
      t.string :rates

      t.timestamps
    end
  end
end
