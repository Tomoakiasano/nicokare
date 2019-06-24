class AddColumnCommentId < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :comment_id, :integer, after: :email
  end
end
