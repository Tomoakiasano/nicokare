class RemoveTeamIdRecreateTeamId < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :team_id
    add_column :users, :team_id, :integer, after: :id
  end
end
