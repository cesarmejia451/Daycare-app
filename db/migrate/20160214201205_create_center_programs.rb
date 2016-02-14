class CreateCenterPrograms < ActiveRecord::Migration
  def change
    create_table :center_programs do |t|
      t.integer :center_id
      t.integer :program_id

      t.timestamps 
    end
  end
end
