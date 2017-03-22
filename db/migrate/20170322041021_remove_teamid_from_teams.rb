class RemoveTeamidFromTeams < ActiveRecord::Migration[5.0]
  def change
    remove_column :teams, :team_id, :string
  end
end
