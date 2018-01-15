class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :content
      t.string :picture
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
