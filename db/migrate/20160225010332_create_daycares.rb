class CreateDaycares < ActiveRecord::Migration
  def change
    create_table :daycares do |t|

      t.timestamps null: false
    end
  end
end
