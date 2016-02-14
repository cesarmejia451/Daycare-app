class CreatePostedTags < ActiveRecord::Migration
  def change
    create_table :posted_tags do |t|
      t.integer :post_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
