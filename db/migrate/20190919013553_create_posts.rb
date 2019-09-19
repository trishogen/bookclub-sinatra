class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :club_id
      t.string :content
    end
  end
end
