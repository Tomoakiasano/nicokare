class RecreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :comment_id
      t.text :content
      t.string :icon
      t.integer :sort
      t.datetime :date
      t.integer :comment_first_user_id
    end
  end
end
